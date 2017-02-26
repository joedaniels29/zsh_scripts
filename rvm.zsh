#!/usr/bin/env zsh

load_rvm(){
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
}
unload_rvm(){
    defined __rvm_unload && __rvm_unload;
    source ${SCRIPTS_FOLDER}/rvm.zsh;
}
