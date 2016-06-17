if [[ -e $SCRIPTS_FOLDER/passwords.pw ]]; then
     source "$SCRIPTS_FOLDER/passwords.pw";
fi
#
# if [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
#
#     # if [[ ! -e /tmp/ ]];
# fi

autorun(){
    local url="/tmp/d29.zsh.autorun.timestamp.$1"
    shift;
    if [[ ! -e $url || $(cat $url) != $(todaysDate) ]]; then
        eval $*;
        todaysDate >! "$url"
    fi
}
