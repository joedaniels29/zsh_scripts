# Widgetize



# Bindings
bindkey -s '\eU' '^Ucd ..; ls^M'
bindkey -s '\eu' '^Ucd ..; ^M'
bindkey -s '\el' '^Uls ^M'

bindkey -s '\es' '^Asudo ^E'
# refresh current dir
bindkey -s '\eR' 'cd .^M rails s ^M'
# open in atom
bindkey -s '\eA' 'atom .^M'

# refresh zsh
bindkey -s '\er\er' 'zsh_reinit;^M'
