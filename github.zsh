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

  }
