# Customize to your needs...
alias ss=sublime
alias g=git
alias SH="ssh harb"
alias G='/Users/joe/Projects/Work/glassfish4/bin/asadmin'
alias es="ember server"
alias atomw='atom --wait'
alias s='swiftBuild'

alias aa=atom .
alias a=atom --wait
alias ss='xcrun swift -sdk $(xcrun --show-sdk-path --sdk macosx)'
openChromeAddress(){
  open -a "Google Chrome"  $1
}

openChromeLocalPort(){
 if [ -f .root_address ];
 then
  openChromeAddress "http://d29.rad.jhmi.edu:${1}/${cat .path_extension}"
 else
  openChromeAddress "http://d29.rad.jhmi.edu:${1}/"
 fi
}

openVPN(){
  osascript $(echo "${JXA_FOLDER}/open_vpn.js")
}
osx_notify(){
  osascript $(echo "${JXA_FOLDER}/notification.js") $3 $1 $2
}
openPostgreSQL(){
 open -a Postgres -j
}
safe_open_idea(){
 if [[ -d .idea ]]; then
  idea $*
 fi
}
export EDITOR="vim"
