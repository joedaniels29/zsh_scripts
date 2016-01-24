# Widgetize
bindkey -s '\er\ef' 'rm -rf '



# Bindings
bindkey -s '\eU' '^Ucd ..; ls^M'
bindkey -s '\eu' '^Ucd ..; ^M'
bindkey -s '\eh' '^Ucd ; ^M'
bindkey -s '\el' '^Uls ^M'

bindkey -s '\eS' '^Asudo ^E'
# refresh current dir
bindkey -s '\eR' 'cd .^M'
# open in atom
bindkey -s '\eA' 'atom .^M'
# Open folder in idea
bindkey -s '\eD' 'idea .^M'
# Open folder in stree
bindkey -s '\eT' 'stree .^M'


# refresh zsh
bindkey -s '\er\er' 'zsh_reinit;^M'
bindkey -s '\eB\eB' 'bower install;^M'
bindkey -s '\eN\eN' 'npm install;^M'
bindkey -s '\eN\eB' 'npm install && bower install;^M'
# Open ZSH config in atom.
bindkey -s '\ea\ez' '~/.zsh_scripts; atom .;^M'
bindkey -s '\eK\eK' 'killServers;^M'

# git status
bindkey -s '\eg\es' 'git status^M'

vcs-status() {
  \print; zle accept-line;
  if [ -d .git ]; then
    git status --short
  elif [ -d .svn ]; then
    svn status
  else
    ls -la # use the "l" alias for ls
  fi
  zle accept-line
}
zle -N vcs-status
bindkey '^ ' vcs-status
