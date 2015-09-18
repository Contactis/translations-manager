#!/bin/bash

#if your tmux counts from 1 instead of 0, change this
START_INDEX_NUMBER=0
SESSION="translation-manager"
FOLDER_FRONTEND=$PWD    # to assign to a variable

#create detached session named $SESSION
tmux new-session -d -s $SESSION

#split the pane horizontally in half
tmux splitw -v -p 50 -t $((START_INDEX_NUMBER+0))

#split both resulting panes vertically in half

tmux splitw -h -p 50 -t $((START_INDEX_NUMBER+1))



tmux selectp -t $((START_INDEX_NUMBER+1))
tmux send-keys "nodemon" 'C-m'

tmux selectp -t $((START_INDEX_NUMBER+2))
tmux send-keys "gulp watch" 'C-m'

#assume support of 256 colors and attach indicated session
tmux -2 attach-session -t $SESSION
