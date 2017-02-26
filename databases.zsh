#!/usr/bin/env zsh
create_db_stack(){
  createuser $1
  if (($# > 1)); then
    createdb -u $2 -O$1 "${1}_development"
    createdb -u $2 -O$1 "${1}_test"
    createdb -u $2 -O$1 "${1}_production"
  else
    createdb -O$1 "${1}_development"
    createdb -O$1 "${1}_test"
    createdb -O$1 "${1}_production"
  fi
}


dump_schema(){
  appname=""
  if [[ -e config/application.name ]]; then
    appname=$(cat config/application.name)
  elif (($# > 1)); then
    appname=$2
  fi

  pg_dump $1 -s > "${appname}_schema.sql"
}
