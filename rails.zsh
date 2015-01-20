
function kill_rails(){
    kill $(cat tmp/pids/server.pid)
}
