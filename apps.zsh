alias aa=atom .
alias a=atom --wait

openChromeAddress(){
  open -a "Google Chrome"  $1
}

openChromeLocalPort(){
  openChromeAddress "http://d29.rad.jhmi.edu:$(expr 4000 + $1)"
}

enterVPN(){
  osascript $(echo "${SCRIPTS_FOLDER}/open_vpn.js")
}
