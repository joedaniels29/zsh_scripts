#!/usr/bin/env zsh

npm_commit_push_publish(){
    gh_commit_push_publish $*
    npm publish ./
}


git_ignore_add(){
    if [[ -f .gitignore ]]; then
        echo $* >> .gitignore
        git rm -rf --cached $*
        gh_commit_push_publish "gitignore: $*"
    else

    fi
}

gh_commit_push_publish(){
       git add .
       git commit -am $1;

       git push origin master
       if (( $# == 2 )); then
           git tag -a $2 -m "$2"
           git push origin master --tags;
       fi
}
gh_ping(){
    ping -c 1 github.com  1> /dev/null 2>&1
    return $?
}
git_each_update_or_overwrite(){
        while read i
        do
            local segments=(${(s. .)i});
            local folder=${segments[1]};
            into $folder;
            git_managed_update
      done < $SCRIPTS_FOLDER/managed_git_list
}


git_managed_update(){
    if gh_ping; then
        git pull --ff-only  1> /dev/null 2>&1;
        git_managed_push_publish
    fi
}
git_managed_push_publish(){
       git add .
       git commit -am "autoc: $(date +%Y-%m-%d:%H:%M:%S)"  1> /dev/null 2>&1;
       if (( $? == 0 )); then
           git push origin master -f
       fi
}


git_be_gone(){
    git checkout -- .
    git clean -df
}

pod_commit_push_publish(){
    if (( $# != 2 )); then
        echo "you need a tag."
        return ;
    fi
    local podspec=( *.podspec.erb );
    erb version=$2 $podspec >! ${podspec:r};
    gh_commit_push_publish $1 v$2;
    pod trunk push ${podspec:r}
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
 git_submodule_oops(){
     git submodule update --init --recursive
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
        git_setup;
    fi
     curl -u "joedaniels29:${___gh_key}" https://api.github.com/user/repos -d "{\"name\":\"${PWD:t}\",\"description\":\"\"}"
     git remote remove origin
     git remote add origin "git@github.com:joedaniels29/${PWD:t}.git"
     git push origin master
}


git_init_readme(){
    local name=$(pwd)(:t)
    if [[ -z ./README* ]]; then



    fi
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

gh_its_gonna_be_great(){
    if (( $# != 1 ));
    then return $(echo "need a directoryProject name.");
    fi
    into $MY_PROJECTS_FOLDER/$1
    git_setup;
    gh_new_repo;
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

gh_project_ssh(){
  echo "${GITHB_SSH_ROOT}/$1.git"
}

op(){
  local projects_for_name=( ~/Projects/**(N)/*(N)$1*(Nom) );

  if [[ -z  $projects_for_name ]]; then
     git ls-remote $(gh_project_ssh $1) 1> /dev/null 2>&1
     if (( $? == 0 )); then
       cd $MY_PROJECTS_FOLDER;
       hub clone "${GITHUB_HANDLE}/$1"
       cd $1;
    elif (( $? == 128 )); then
      echo 'searchGithub? '
    fi
  else
    local ret;
    if (( $#projects_for_name > 1 )); then
      select l in $projects_for_name; do
        if $l; then break; fi
      done
    else
         ret=$projects_for_name
    fi
    cd $ret;
  fi
}

function _op(){
  _values 'Project' ~/Projects/*/*/(:t)
  return ret
}

compdef _op op

gh_my_repos(){
  curl -s "https://api.github.com/users/joedaniels29/repos?per_page=1000" | grep -o 'git@[^"]*'
}
git-all(){
  unload_rvm
  local first_dir=$(pwd);
  local all_git_projects=( ~/Projects/{Work,Mine}/*/.git(:h) );
  local ccmd="$*";
  for dir in $all_git_projects; do
   # print $fg[yellow] "==> ${dir:t} <==";
   cd $dir;
   eval ${ccmd}
  done;
  load_rvm
  cd $first_dir
}
git-check(){
  git-all "if [[ $0  -eq 1 ]]; then echo 'dirty'; fi "
}
git-has-remote-branch(){
    local hasRemote=$(git ls-remote --heads origin $1 | wc -l)
    if [[ hasRemote -eq 1 ]]; then
        return 0;
    else
        return 1
    fi

}
git-rebase-all-onto(){
   local onto=$1;
   shift;
    for x in  $* ; do
        echo REBASE $x
        git checkout $x;
        git rebase $onto;
        if [[ $? -ne 0 ]]; then
            inline_source_tree
        fi
        git-has-remote-branch $x
        if [[ $? -eq 0 ]]; then
            git push -f origin $x
        fi
    done
    git checkout $onto;
}

inline_source_tree(){
    /Applications/SourceTree.app/Contents/MacOS/SourceTree
}

git-check-list(){
    autoload colors; colors;
    print -n  $(git-all "eval \"$*\";"  'if [[ $?  -ne 0 ]]; then; print -n $fg_bold[blue] `pwd`(:t) ${reset_color}; else; print -n $fg[white] `pwd`(:t) ${reset_color}; fi;')
}
#
alias git-all-s="git-all git --no-pager status -sb"
alias git-all-l="git-all git --no-pager log --decorate --graph --oneline -n 3"
# alias git-all-d="git-all git diff"
# alias git-all-dc="git-all git diff --cached"
# alias git-all-n="git-all npm ls"
