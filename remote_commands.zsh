ssh_gtail(){
  if (($# == 0)) || [[ "$1" == "local" ]]; then
    tail -f /Users/josephdaniels/Projects/Work/glassfish4/glassfish/domains/domain1/logs/server.log
  else
    ssh $1 "tail -f /servers/glassfish/glassfish3/glassfish/domains/domain1/logs/server.log"
  fi
}
