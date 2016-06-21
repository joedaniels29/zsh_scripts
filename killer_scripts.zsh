close_devlelopment(){
    killall rails  &>/dev/null;
    killall ember  &>/dev/null;
    killall java  &>/dev/null;
    killall mongod  &>/dev/null;
    osx_quit $(current_xcode)  &>/dev/null;
    osx_quit postgres  &>/dev/null;
    osx_quit dash  &>/dev/null;
    osx_quit dropbox  &>/dev/null;
    osx_quit SourceTree &>/dev/null;
    quitvpn  &>/dev/null;
    sudo purge  &>/dev/null;
}


startvpn() {
        sudo launchctl load -w /Library/LaunchDaemons/net.juniper.AccessService.plist  &>/dev/null;
        launchctl load -w /Library/LaunchAgents/net.juniper.pulsetray.plist  &>/dev/null;
}
quitvpn() {
        launchctl unload -w /Library/LaunchAgents/net.juniper.pulsetray.plist  &>/dev/null;
        sudo launchctl unload -w /Library/LaunchDaemons/net.juniper.AccessService.plist  &>/dev/null;
        osascript -e 'tell application "Junos Pulse" to quit';
}
current_xcode(){
    print $( xcode-select --print-path )(:h:h:t);
}

osx_quit(){
    osascript -e "quit app \"$*\"";
}
