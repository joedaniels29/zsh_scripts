checkEnvironment(){
  # todo: open postgres if its not already open?
  if ! pgrep postgress >& - ; then
    openPostgreSQL
  fi

  openVPN
}

alias JRJ=jruby --1.9 -S

hopkins_current_host(){
  if [[ "$(hostname)" == "rad-ai-dev02" ]]; then
   echo "harb.rad.jhmi.edu"
  elif [ "$(current_host_platform)" = "osx" ]; then
   # assume local.
   echo "d29.rad.jhmi.edu"
  fi
}
