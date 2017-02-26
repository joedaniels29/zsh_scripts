#!/usr/bin/env zsh

deref() { print ${(P)1}; print ${(P)1[-1]}; }

function defined (){
  whence -w $1 >/dev/null
}
