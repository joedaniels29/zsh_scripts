ember_apps=(
  ~/Projects/Work/resident-worklist/frontend
  ~/Projects/Work/VTE/frontend
  ~/Projects/Work/ReachSearch/frontend
  ~/Projects/Work/MRIProject/frontend
  ~/Projects/Work/GSSRegistration/frontend
  ~/Projects/Work/BiopsyProject/frontend
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

function if_thing(){
   echo "current Version: $(ember -v)"
   select var in Yes No; do
    case $var in
      Yes)
       exit
       ;;
      No)
       break;;
    esac
    echo "Yu said: $var"
   done

}


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

    select yn in "stash" "continue" "stop"; do
      case $yn in
        # [cC]* ) echo "; break;;
        stash) git stash; break;;
        contine) break;;
        no) echo -1; break;;
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



function ember_version(){
  ember -v | ruby -e 'puts STDIN.read.to_s.split("\n").select{|a|a.match("version: ")}.first.sub("version: ","")'
}

function ember_update(){
    print "EMBER FULL UPDATE"

    npm cache clean >&-
    bower cache clean >&-
    echo "cache cleaned"
    if !command -v ember 2>/dev/null; then
      npm install ember-cli
    else
     echo "Want to install global?"
     echo current Version: $( ember_version )
     select var in Yes No; do
      case $var in
        Yes)
         npm uninstall -g ember-cli < /dev/null
         npm install -g ember-cli < /dev/null
         echo "installed global";
         break;;
        No)
         break;;
      esac
      echo "please, yes or no"
     done
    fi
    echo "👍"

    newVersion=$( ember_version )
    for ember_app in $ember_apps; do
        cd $ember_app;
        echo "entering App: $ember_app"
        appVersion=$( ember_version )

        if [ "$appVersion" -eq "$newVersion" ]; then

         echo "app reports already using version $newVersion, skip?"

         select response in Skip Dont; do
          case $response in
           Skip) break;;
           Dont) break;;

         esac
        done
        fi

        if (( $(_check_repo_sanitation()) == 0 )); then; return; fi;

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



function startServers(){
  if [[ -z $1 ]]; then
    echo "No port Supplied. Default to 3000/4000";
    1=0;
  fi
    rails s -p$(expr 3000 + $1)&
    cd frontend
    ember s --port $(expr 4000 + $1) --proxy http://d29.rad.jhmi.edu:$(expr 3000 + $1)/&  echo $! > .ember.pid
    1
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
    npm install; bower install;
    node_modules/ember-cli/bin/ember build $2;
    1;

    cp -r frontend/dist public
    rm -f public/index.html
    rm -f  $1
    cp frontend/dist/index.html $1
}
