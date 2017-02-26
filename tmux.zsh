#!/usr/bin/env zsh

# local me hopkins;
# me="Hi Me!😅";
# hopkins="Hopkins🏥";
# # current_projects=(sRS sOAS)
# # _find_or_create_session(){
# #  tmux has-session -t "$1"
# #  if [ $? != 0 ]
# #  then
# #    TMUX='' tmux new-session -s "$1" -d
# #  fi
# #  tmux switch-client -t "$1"
# # }
# #
# tsh(){
# #  _find_or_create_session $hopkins jump_in
# # }
# # tsp(){
# #  _find_or_create_session $me
# # }
# #
# jump_in(){
#  # tmux rename-session "Me!"
#  # tmux new -s "Hopkins"
#  # tmux rename-session "$hopkins"
#  # tmux rename-window shell
#  for project in $current_projects; do
#   tmux new-window -n $project
#   tmux send "sleep 3 && $project" C-m
#   tmux new-window -t 9 -n server
#   tmux send "ls -al" C-m
#   tmux split-window -h
#   tmux send "echo yas" C-m
#   tmux split-window -v
#   tmux send "echo yas" C-m
#  done
# }
