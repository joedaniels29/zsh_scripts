npm_commit_push_publish(){
    gh_commit_push_publish $*
    npm publish ./
}

gh_commit_push_publish(){
       git add .
       git commit -am $1;
       git push origin master
 }