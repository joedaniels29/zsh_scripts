
ember_apps=(
/Users/josephdaniels/Projects/Work/resident-worklist/frontend
/Users/josephdaniels/Projects/Work/VTE/frontend
/Users/josephdaniels/Projects/Work/ReachSearch/frontend
/Users/josephdaniels/Projects/Work/MRIProject/frontend
/Users/josephdaniels/Projects/Work/GSSRegistration/frontend
/Users/josephdaniels/Projects/Work/BiopsyProject/frontend
/Users/josephdaniels/Projects/Work/MRIProject/frontend/
)
function ember_update(){
    print "something! "
    echo "installing global"
    npm install -g ember-cli
    echo "👍"

    for ember_app in $ember_apps; do

        cd $ember_app;
        echo "entering App: ${ember_app}"
        echo "cleaning..."
        rm -rf node_modules bower_components dist
        npm install --save-dev ember-cli
        npm install;
        bower install;
        ember init

    done

}



function startServers(){
    rails s -p$(expr 3000 + $1)&
    cd frontend
    ember s --port $(expr 4000 + $1) --proxy http://d29.rad.jhmi.edu:$(expr 3000 + $1)/&  echo $! > .ember.pid
    1
    open -a "Google Chrome"  "http://d29.rad.jhmi.edu:$(expr 4000 + $1)"
}


function killServers(){
  kill_rails
  if [ -d "frontend" ]; then
    cd frontend
    if [ -a ".ember.pid" ]; then
      kill $(cat .ember.pid)
      rm -rf .ember.pid
    else
      killall ember
      rm -rf .ember.pid
    fi
    1
  fi
}


function ember_mock_data(){
    mv disabledServer server;
}
function ember_real_data(){
    mv server disabledServer;
}

function ember_rails_install(){
    rm -rf public;
    cd frontend;
    rm -rf node_modules bower_components
    npm install; bower install;
    node_modules/ember-cli/bin/ember build --environment=production;
    1;

    cp -r frontend/dist public
    rm -f public/index.html
    yes | rm $1
    cp frontend/dist/index.html $1
}
