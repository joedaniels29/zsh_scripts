#!/usr/bin/env zsh

xcreset(){
    rm -rf ~/Library/Developer/CoreSimulator/
    rm -rf ~/Library/Developer/Xcode/DerivedData
    rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache"
}
xc_is_ok(){
    if (( $# == 1 ));
    then xattr -d com.apple.quarantine $1;
    else xattr -d com.apple.quarantine com.apple.quarantine "/Applications/Xcode.app";
    fi

}

xc_new_framework(){
    if (( $# == 1 ));
    then
        cd $MY_PROJECTS_FOLDER;
        git clone https://github.com/joedaniels29/FrameworkTemplate.git $1;
        if (( $? == 0 )); then
            cd $1;
            ./rename-project.sh $1
            rm -f ./rename-project.sh
            rm -rf .git;
            curl 'https://gist.githubusercontent.com/joedaniels29/c9165643c26a15efd0487a57445c90a4/raw/' > $1.podspec.erb
            curl 'https://gist.githubusercontent.com/joedaniels29/8eaf80c8828c968dd97ca3ffc541f141/raw/' > README.md
            gh_new_repo
        else echo "baaad. Maybe no internet?"
        fi
    else echo "args: project name"
    fi

}
