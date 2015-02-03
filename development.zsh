

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
