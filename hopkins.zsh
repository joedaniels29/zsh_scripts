checkEnvironment(){
  # todo: open postgres if its not already open?
  if ! pgrep postgress >& - ; then
    openPostgreSQL
  fi
  
  openVPN
}

alias JRJ=jruby --1.9 -S
