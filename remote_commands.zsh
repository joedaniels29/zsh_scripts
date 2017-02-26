#!/usr/bin/env zsh

# . ./passwords.pw

RGTail(){
  if (($# == 0)) || [[ "$1" == "local" ]]; then
    tail -f /Users/joe/Projects/Work/glassfish4/glassfish/domains/domain1/logs/server.log
  else
    ssh $1 "tail -f /servers/glassfish/glassfish3/glassfish/domains/domain1/logs/server.log"
  fi
}

RGServiceOpp(){
 if (($# == 0)) || [[ "$1" == "local" ]]; then
   tail -f /Users/joe/Projects/Work/glassfish4/glassfish/domains/domain1/logs/server.log
 else
   ssh $1 "echo ${___work_default_passoword} | sudo service glassfish $2"
 fi
 osx_notify "Remote glassfish" "done running command" $2
}

RGRestart(){
  RGServiceOpp $1 restart
}

RGStop(){
  RGServiceOpp $1 stop
}

RGStart(){
  RGServiceOpp $1 start
}
