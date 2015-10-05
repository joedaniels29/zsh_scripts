ember_apps=(
/Users/joe/Projects/Work/resident-worklist/frontend
/Users/joe/Projects/Work/ReachSearch/frontend
/Users/joe/Projects/Work/MRIProject/frontend
)

shared_bower=(
"textillate"
"animate.css"
"Lettering.js"
"momentjs"
)

shared_npm=(
"ember-cli-font-awesome"
"ember-cli-coffeescript"
"ember-cli-ramdisk"
"ember-cli-sass"
"ember-pikaday"
)





function _checkGit(){
  return $(git diff-index --name-only HEAD --);
}



function _shortened_pwd(){
  # returns path without ~/Projects/
  # good for paths relative to Projects/
  return _shortened_path($(pwd))
}
function _shortened_path(){
  # returns path without ~/Projects/
  # good for paths relative to Projects/
  return ${$1##$(cd; pwd)/Projects/}
}
function _check_repo_sanitation(){
  red='\033[0;31m'
  cyan='\033[0;36m'
  NC='\033[0m' # No Color

  diff = _checkGit()
  if [ -z diff ]; then
    echo "This app: ${red}${_shortened_pwd()}${NC} has uncommitted work"
    echo $diff
    # echo "Commit ${cyan}(c)${NC},  Stash to put it off ${cyan}(s)${NC}, just continue (x) or abort ${cyan}(q)${NC}"
    echo "Stash to put it off ${cyan}(s)${NC}, just continue (x) or abort ${cyan}(q)${NC}"

    select yn in "Yes" "No"; do
      case $yn in
        # [cC]* ) echo "; break;;
        [sS]* ) git stash; break;;
        [xX]* ) break;;
        [qQ]* ) exit;;
      esac
    done
  fi
}
function ember_each(){
  red='\033[0;31m'
  cyan='\033[0;36m'
  NC='\033[0m' # No Color
  # echo "confirm you want to run ${cyan}$1${NC} in ${red}EACH${NC} Ember Repo?"
  # select opt in "y" "n"; do
  #   if [ "$opt" = "y" ]; then
  #     # echo done
  #     break;
  #     # exit
  #   elif [ "$opt" = "n" ]; then
  #     exit;
  #   fi
  #
  # done
  for ember_app in $ember_apps; do
    cd $ember_app

  done
}




function ember_update(){
    print "Updating!"
    echo "installing global"
    npm uninstall -g ember-cli
    npm cache clean
    bower cache clean
    npm install -g ember-cli

    echo "👍"


    for ember_app in $ember_apps; do
        cd $ember_app;
        echo "entering App: ${ember_app}"
        _check_repo_sanitation()

        rm -rf node_modules bower_components dist tmp
        npm install --save-dev ember-cli

        ember install;
        ember init
    done

    echo "Complete! Ran updates on:"
    for e_a in $ember_apps; do
      echo $e_a
    done
}


function startServersR(){
 if [[ -z $1 ]]; then
   echo "No port Supplied. Default to 3000/4000";
   1=0;
 fi
 rails s -p$(expr 3000 + $1) &
}

function startServersE(){
 if [[ -z $1 ]]; then
   echo "No port Supplied. Default to 3000/4000";
   1=0;
 fi
 cd frontend
 ember s --port $(expr 4000 + $1) --proxy http://d29.rad.jhmi.edu:$(expr 3000 + $1)/&  echo $! > .ember.pid
 1
}

function startServers(){
  if [[ -z $1 ]]; then
    echo "No port Supplied. Default to 3000/4000";
    1=0;
  fi
    startServersR $1
    startServersE $1
    openChromeLocalPort  $(expr 4000 + $1)
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
function killEmber(){
 if [ -a ".ember.pid" ]; then
   kill $(cat .ember.pid)
   rm -rf .ember.pid
 else
   killall ember
   rm -rf .ember.pid
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
    if [[ -d "disabledServer" ]]; then
      # go back to regular
      ember_mock_data
    fi
    rm -rf node_modules bower_components
    npm install &
    pid1=$!
    bower install &
    pid2=$!
    wait $pid1 $pid2
    node_modules/ember-cli/bin/ember build $2;
    1;

    cp -r frontend/dist public
    rm -f public/index.html
    rm -f  $1
    cp frontend/dist/index.html $1
}
