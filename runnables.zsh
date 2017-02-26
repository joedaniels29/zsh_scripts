#!/usr/bin/env zsh

zsh_runnables_exec(){
    for f ($RUNNABLES_FOLDER/*(N)) {
        for file ($f/*(N${f:t})){
            source $file;
            touch $file;
        }
    }
}
