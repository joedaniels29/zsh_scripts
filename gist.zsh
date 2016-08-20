gistURL(){
    local x;
    x=$(gist $1);
    if [[ $? -eq 0 ]]; then
    echo $x | pbcopy;
    else
        echo no good!!!;
        return 1;
    fi
}
save_for_script(){
    if (( $# != 1)); then
        echo "oh i saved you from a stupid!";
        return -1;
    fi
    gistURL $1;
    if [[ $? -eq 0 ]]; then
        echo "wget $(pbpaste)/raw -O $(realpath $1)" >> $SETUP_SCRIPT;
        local dir=$(pwd);
        cd $SETUP_SCRIPT_FOLDER;
        gh_commit_push_publish "add $1 as an install step."
        return 0
    else
        return 1;
    fi

}
