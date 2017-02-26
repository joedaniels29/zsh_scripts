#!/usr/bin/env zsh


rails_apps=(
/Users/joe/Projects/Work/resident-worklist/
/Users/joe/Projects/Work/VTE/
/Users/joe/Projects/Work/ReachSearch/
/Users/joe/Projects/Work/MRIProject/
/Users/joe/Projects/Work/GSSRegistration/frontend
)

deployment_string="group(:production){ gem 'jruby-openssl', '0.8.8'}"

er_deploy(){
  appname=$(cat config/application.name)
  if [ -z $appname ]; then
    echo "please supply the application's name:"
    read appname
    echo "Got it! New app name: ${appname}"
    echo $appname >! config/application.name
  fi


  RAILS_ENV=production jruby -J-XX:MaxPermSize=256m -S bundle install &
  piddy1=$!
  ember_rails_install $1 --environment=production
  wait $piddy1

  # git checkout app/views/pages/_version.html.erb &
}


er_startup(){
 bundle install;
  cd frontend;
  npm install;
  bower install;
  1;

}
er_deploymode(){
  if ! grep -Fxq $deployment_string Gemfile ; then
    echo $deployment_string >>| Gemfile
  fi
}


er_devmode(){
  sed -e "s/$deployment_string//g" Gemfile >! _Gemfile;
  mv -f _Gemfile Gemfile
  bundle install
}

bundle_cleanupAllProjects(){
  for rails_app in $rails_apps; do
    cd $rails_app
    bundle clean --force

  done
}


staRSe(){
 cd "${WORK_PROJECTS_FOLDER}/ReachSearch"
 startServersE 378
}

staRSr(){
 cd "${WORK_PROJECTS_FOLDER}/ReachSearch"
 startServersR 378
}

staRS(){
 cd "${WORK_PROJECTS_FOLDER}/ReachSearch"
 startServers 378
}

trelawney_update(){
  bundle update trelawney;
  rails g trelawney:rvmrc;
}
