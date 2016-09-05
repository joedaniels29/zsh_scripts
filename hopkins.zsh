checkEnvironment(){
  # todo: open postgres if its not already open?
  if ! pgrep postgress >& - ; then
    openPostgreSQL
  fi

  openVPN
}
export CLASSPATH="$CLASSPATH:/Users/joe/Projects/Work/glassfish4/glassfish/lib/gf-client.jar:/Users/joe/Projects/Work/glassfish4/glassfish/lib/jndi-properties.jar:/Users/joe/Projects/Work/glassfish4/glassfish/lib/postgresql-9.2-1002.jdbc4.jar:/Users/joe/Projects/Work/glassfish4/glassfish/lib/sqljdbc4.jar"
alias JRJ=jruby --1.9 -S
alias JRJ=jruby --1.9 -S

hopkins_current_host(){
  if [[ "$(hostname)" == "rad-ai-dev02" ]]; then
   echo "harb.rad.jhmi.edu"
  elif [ "$(current_host_platform)" = "osx" ]; then
   # assume local.
   echo "d29.rad.jhmi.edu"
  fi
}
if [[ "$(uname)" == "Darwin" ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
fi
