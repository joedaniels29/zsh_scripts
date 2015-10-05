alias aa=atom .
alias a=atom --wait
alias ss='xcrun swift -sdk $(xcrun --show-sdk-path --sdk macosx)'
openChromeAddress(){
  open -a "Google Chrome"  $1
}

openChromeLocalPort(){
  openChromeAddress "http://d29.rad.jhmi.edu:${1}"
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
