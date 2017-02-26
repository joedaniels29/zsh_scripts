#!/usr/bin/env zsh

function zsh_reinit(){
  . ~/.zshrc
}
function zsh_update(){
  cd ~/.zsh_scripts/
  git pull;
  zsh_reinit;
  1;
}
