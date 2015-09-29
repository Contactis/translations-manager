#!/bin/bash

#if your tmux counts from 1 instead of 0, change this
START_INDEX_NUMBER=0
SESSION="transman"      # translation-manager
FOLDER_FRONTEND=$PWD    # to assign to a variable

#create detached session named $SESSION
tmux new-session -d -s $SESSION

#split the pane horizontally in half
tmux splitw -h -p 50 -t $((START_INDEX_NUMBER+0))

#split both resulting panes vertically in half
tmux splitw -v -p 50 -t $((START_INDEX_NUMBER+0))

tmux selectp -t $((START_INDEX_NUMBER+0))
tmux send-keys "git log --graph --all --abbrev-commit --date=relative --format=format:'%C(bold red)%h%C(reset) %C(bold magenta)(%ar)%C(reset) %C(white)%s%C(reset) %C(bold blue) %an%C(reset)%C(auto)%d%C(reset)'" 'C-m'

tmux selectp -t $((START_INDEX_NUMBER+2))
tmux send-keys "gulp watch" 'C-m'

#assume support of 256 colors and attach indicated session
tmux -2 attach-session -t $SESSION
