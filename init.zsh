if [[ -e $SCRIPTS_FOLDER/passwords.pw ]]; then
     source "$SCRIPTS_FOLDER/passwords.pw";
fi
export SWIFTENV_ROOT=/usr/local/var/swiftenv
 if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi
#
# if [[ "$(expr substr $(uname -ss) 1 5)" -eq  "Linux" ]]; then
#     autorun "zsh_update" "zsh_update"
# fi
#
# autorun(){
#     local url="/tmp/d29.zsh.autorun.timestamp.$1";
#     shift;
#     if [[ ! -e $url || $(cat $url) != $(todaysDate) ]]; then
#         todaysDate >! "$url";
#         eval $*;
#     fi
# }
