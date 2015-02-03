
rails_apps=(
/Users/josephdaniels/Projects/Work/resident-worklist/
/Users/josephdaniels/Projects/Work/VTE/
/Users/josephdaniels/Projects/Work/ReachSearch/
/Users/josephdaniels/Projects/Work/MRIProject/
/Users/josephdaniels/Projects/Work/GSSRegistration/frontend
)

deployment_string="group(:production){ gem 'jruby-openssl', '0.8.8';}"

er_deploy(){
  er_deploymode
  ember_rails_install $1 --environment=production
  RAILS_RELATIVE_URL_ROOT="/$APPNAME" RAILS_ENV=production jruby -J-XX:MaxPermSize=256m -S bundle exec rake assets:precompile
  RAILS_ENV=production  warble war
  chmod +r "$APPNAME.war"
  mv -v "$APPNAME.war" "$APPNAME.war.`git describe --always`"
  git checkout app/views/pages/_version.html.erb
  er_devmode
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
