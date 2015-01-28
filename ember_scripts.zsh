
ember_apps=(
/Users/josephdaniels/Projects/Work/resident-worklist/frontend
/Users/josephdaniels/Projects/Work/VTE/frontend
/Users/josephdaniels/Projects/Work/ReachSearch/frontend
/Users/josephdaniels/Projects/Work/MRIProject/frontend
/Users/josephdaniels/Projects/Work/GSSRegistration/frontend
/Users/josephdaniels/Projects/Work/BiopsyProject/frontend
/Users/josephdaniels/Projects/Work/MRIProject/frontend/
)

function _checkGit(){
  return $(git diff-index --name-only HEAD --);
}

function _kindof_relative_path(){
  # returns path without ~/Projects/
  # good for paths relative to Projects/
  return ${$(pwd)##$(cd; pwd)/Projects/}
}
function _check_repo_sanitation(){
  red='\033[0;31m'
  cyan='\033[0;36m'
  NC='\033[0m' # No Color

  diff = _checkGit()
  if [ -z diff ]; then
    echo "This app: ${red}${_kindof_relative_path()}${NC} has uncommitted work"
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
    npm install -g ember-cli

    echo "👍"


    for ember_app in $ember_apps; do

        cd $ember_app;
        echo "entering App: ${ember_app}"
        _check_repo_sanitation()

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


function ember_rails_full_deploy(){
  ember_rails_install $1 --environment=production

  ./wariblizer.sh

  # if(($# == 3)); then
    # scp  $3:/tmp
  # fi
}


function ember_rails_install(){
    rm -rf public;
    cd frontend;
    rm -rf node_modules bower_components
    npm install; bower install;
    node_modules/ember-cli/bin/ember build $2;
    1;

    cp -r frontend/dist public
    rm -f public/index.html
    rm -f  $1
    cp frontend/dist/index.html $1
}
