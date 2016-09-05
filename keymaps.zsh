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
bindkey -s '\eX\eC' 'open_xcode_project; ^M'

# update... whatever
bindkey -s '\eY' 'all_update^M'


# rvm use...
bindkey -s '\er\es' 'rvm use system^M'
bindkey -s '\er\ed' 'rvm use default^M'
bindkey -s '\er\e3' 'rvm use ruby-2.3.1^M'


# refresh zsh
bindkey -s '\er\er' '^A^kzsh_reinit;^M'
bindkey -s '\eB\eB' 'bower install;^M'
bindkey -s '\eN\eN' 'npm install;^M'
bindkey -s '\eN\eB' 'npm install && bower install;^M'
# Open ZSH config in atom.
bindkey -s '\ea\ez' '~/.zsh_scripts; atom .;^M'
bindkey -s '\ea\et' '~/.tmuxinator; atom .;^M'
bindkey -s '\ea\es' '~/.ssh; atom .;^M'
bindkey -s '\eK\eK' 'killServers;^M'


bindkey -s '\eH\eB' 'hub browse;^M'


bindkey -s '\eO' '^A^kop  \t'
# git status
bindkey -s '\eg\es' 'git status^M'

vcs-status() {
  print; zle accept-line;
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
