
rails_apps=(
/Users/josephdaniels/Projects/Work/resident-worklist/
/Users/josephdaniels/Projects/Work/VTE/
/Users/josephdaniels/Projects/Work/ReachSearch/
/Users/josephdaniels/Projects/Work/MRIProject/
/Users/josephdaniels/Projects/Work/GSSRegistration/frontend
)

deployment_string="group(:production){ gem 'jruby-openssl', '0.8.8';}"

er_deploy(){
  appname=$(cat config/application.name)
  if [ -z $appname ]; then
    echo "please supply the application's name:"
    read appname
    echo "Got it! New app name: ${appname}"
    echo $appname >! config/application.name
  fi

  rm -rf ./*.war* > /dev/null
  er_deploymode > /dev/null
  ember_rails_install $1 --environment=production
  RAILS_RELATIVE_URL_ROOT="/$appname" RAILS_ENV=production jruby -J-XX:MaxPermSize=256m -S bundle exec rake assets:precompile
  RAILS_ENV=production  warble war
  chmod +r "$appname.war"
  newappname="$appname.war.`git describe --always`"
  mv -v "$appname.war" $newappname
  git checkout app/views/pages/_version.html.erb
  er_devmode > /dev/null

  if (($# > 1 )); then
    scp $newappname $2:/tmp
    echo "uploading.... "
    ssh $2 "/servers/glassfish/glassfish3/glassfish/bin/asadmin deploy --name=$appname --contextroot=$appname --force=true  /tmp/$newappname"
  fi


}
er_deploymode(){
  if ! grep -Fxq $deployment_string Gemfile ; then
    echo $deployment_string >>| Gemfile
    RAILS_ENV=production jruby -J-XX:MaxPermSize=256m -S bundle install
  fi
}
er_devmode(){
  sed -e "s/$deployment_string//g" Gemfile >! _Gemfile;
  mv -f _Gemfile Gemfile
  bundle install

}
