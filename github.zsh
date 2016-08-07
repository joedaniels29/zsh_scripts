npm_commit_push_publish(){
    gh_commit_push_publish $*
    npm publish ./
}

gh_commit_push_publish(){
       git add .
       git commit -am $1;
       git push origin master
}
gh_pages_initialize(){
    ember build;
    git remote add site  $2;
    git add $1 && git commit -m "Initial $1 subtree commit";
    git subtree push --prefix $1 site master
}
__gh_pages_publish(){
    local dir=$(echo $1);
    ember build;
    shift;
    git add $dir;

    git commit -m $*;
    git commit -am "all source related to previous commit: $*";

    git subtree push --prefix $dir site master;
    git push origin master;
}
gh_pages_publish(){
    __gh_pages_publish dist $*
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
if [[ ! -d .git ]]; then
    echo "ohai";
fi
 curl -u "joedaniels29:${___gh_key}" https://api.github.com/user/repos -d "{\"name\":\"${PWD:t}\",\"description\":\"\"}"
 git remote add origin "git@github.com:joedaniels29/${PWD:t}.git"
 git push origin master
}



git-all(){
  unset rvm_project_rvmrc
  local first_dir=$(pwd);
  local all_git_projects=( ~/Projects/{Work,Mine}/*/.git(:h) );
  local ccmd="$*";
  for dir in $all_git_projects; do
   mv -f ${dir}/.{,no}rvmrc 1> /dev/null 2>&1
   # print "==> $dir <==";
   cd $dir;
   eval "$ccmd"
   mv -f ${dir}/.{no,}rvmrc 1> /dev/null 2>&1
  done;
  export rvm_project_rvmrc=1
  cd $first_dir
}

gh_cdn_add(){
    if (($# != 2)); then
        echo need a file and a subdir
        return ;
    fi
    local loc=$(pwd);
    local from="$loc/$1"
    local file=$CDN_FOLDER/$2/${1:t}
    if (( $(file_size_mb $1) > 10 )); then
        echo "too big 😭"
        return ;
    fi
    cd $CDN_FOLDER;

    mkdir -p $2;
    cp -f $from $file;
    # cd $file(:h);
    gh_commit_push_publish "Added: $file";
    cd $loc
    local url=https://raw.githubusercontent.com/joedaniels29/cdn/$file

    echo $url | pbcopy
    echo $url;
    echo "its on the clipboard too!";
}
# git-all(){
#   unset rvm_project_rvmrc
#   local first_dir=$(pwd);
#   local all_git_projects=( ~/Projects/{Work,Mine}/*/.git(:h) );
#   local ccmd="$*";
#   for dir in $all_git_projects; do
#    mv -f ${dir}/.{,no}rvmrc 1> /dev/null 2>&1
#    # print "==> $dir <==";
#    cd $dir;
#    eval "$ccmd"
#    mv -f ${dir}/.{no,}rvmrc 1> /dev/null 2>&1
#   done;
#   export rvm_project_rvmrc=1
#   cd $first_dir
# }
# git-check(){
#   git-all "if [[ $0  -eq 1 ]]; then echo 'dirty'; fi "
# }
#
# alias git-all-s="git-all git --no-pager status -sb"
# alias git-all-l="git-all git --no-pager log --decorate --graph --oneline -n 3"
# alias git-all-d="git-all git diff"
# alias git-all-dc="git-all git diff --cached"
# alias git-all-n="git-all npm ls"
