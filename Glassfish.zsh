#!/usr/bin/env zsh

startGlassfish() {
  G start-domain --verbose 1>/dev/null 2>/dev/null & ;
  if ! pgrep postgress >& - ; then
    openPostgreSQL;
  fi;
  }
