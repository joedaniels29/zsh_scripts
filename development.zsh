

function VmOpp(){
    vmrun
}


function git_init_gitignore(){
    echo "#----autogenerated gitignore----
.idea
*.iml
public/assets
.DS_Store
.ember.pid
node_modules/
bower_components/

/vendor/bundle
disabledServer/
/public/

#CocoaPods
Pods/
GeneratedDocumentation/
Carthage.checkout/
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3
/target
/log/*.log
/tmp
" >>| .gitignore

}

function git_setup(){
  git_init_gitignore;
  git init;
  git add .
  git commit -m "Initial commit"
  if [ ! -z $1 ]; then
    git_push_to_github $1
  fi
}
function git_push_to_github(){
  git remote add origin $1
  git push origin master
}
function no_index_here(){
   touch .metadata_never_index;
}



function all_update(){
 if [[ -e ./Gemfile ]] {
  bundle install
 }
 if [[ -e ./package.json ]] {
  npm install
 }
 if [[ -e ./bower.json ]] {
  bower install
 }
 if [[ -e ./cartfile ]] {
  carthage update
 }
 if [[ -e ./Podfile ]] {
  pod update
 }
 if [[ -d ./frontend ]] {
  cd frontend;
  all_update
  1
 }
}





current_host_platform(){
 if [[ "$(uname)" == "Darwin" ]]; then
  echo "osx"
  elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  echo "linux"
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "win"
  fi
}
