npm_commit_push_publish(){
    gh_commit_push_publish $*
    npm publish ./
}

gh_commit_push_publish(){
       git add .
       git commit -am $1;
       git push origin master
 }
 git_push_to_origin(){
       git add .;
       git commit -am $1;
       git push origin
 }
 git_clone_into(){
        cd ~/Projects/Mine;
        git clone $1;
        if [[ -a $1:t:r ]]; then
         echo "cd ${1:t:r}"
         cd $1:t:r
        else
         echo "command failed or dir:  \"${1:t:r}\" was just too wierd."
        fi
        open_xcode_project
  }

open_xcode_project(){
  if ls ./*.xcworkspace 1> /dev/null 2>&1; then
   open *.xcworkspace;
  elif ls ./*.xcodeproj 1> /dev/null 2>&1; then
   open ./*.xcodeproj;
  fi
}
# open_xcode_project(){

# }

gh_new_repo(){
 curl -u "joedaniels29:${___gh_key}" https://api.github.com/user/repos -d "{\"name\":\"${PWD:t}\",\"description\":\"\"}"
 git remote add origin "git@github.com:joedaniels29/${PWD:t}.git"
 git push origin master
}
