
function kill_rails(){
  if [[ -a tmp/pids/server.pid ]]; then
   kill $(cat tmp/pids/server.pid) &>/dev/null;
   if [[ $? -ne 0 ]]; then
     kill -9 $(cat tmp/pids/server.pid) &>/dev/null || rm -f tmp/pids/server.pid
   fi
  else
   echo "not in rails dir or no server running?"
  fi
}
