alias aa=atom .
alias a=atom --wait

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
  osascript $(echo "${JXA_FOLDER}/notification.js") &> /dev/null
}
