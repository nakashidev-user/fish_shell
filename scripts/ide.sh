#!/bin/bash

# set tmux panes for ide

function getPaneId() {
  wezterm cli list --format json | jq "[.[] | select(.tab_title | contains(\"$1\"))] | first | .pane_id"
}

if [ "$#" -eq 0 ]; then
  # tmux split-window -v
  # tmux split-window -h
  # tmux resize-pane -D 15
  # tmux select-pane -t 1

  tmux split-window -h
  tmux split-window -v
  tmux resize-pane -D 20
  tmux select-pane -t 1
  clear
else
  case $1 in
    0)
      tmux split-window -h
      tmux select-pane -t 0 
      tmux split-window -v
      tmux resize-pane -D 10 
      tmux resize-pane -L 25
      tmux select-pane -t 2
      clear
      ;;
    1)
      tmux split-window -v
      tmux resize-pane -D 15 
      tmux split-window -h 
      tmux resize-pane -L 30 
      tmux split-window -h 
      # wezterm cli split-pane --bottom --percent 20
      # wezterm cli activate-pane-direction Next
      # wezterm cli split-pane --left --percent 40
      # wezterm cli activate-pane-direction Next
      # wezterm cli split-pane --left --percent 50
      clear
      ;;
    2)
      tmux split-window -h
      tmux split-window -v
      tmux resize-pane -D 15
      tmux select-pane -t 1
      tmux split-window -v
      tmux select-pane -t 1
      clear
      ;;
    go)
      cd ~/go/src
      tmux split-window -v
      tmux split-window -h
      tmux resize-pane -D 15
      tmux select-pane -t 1
      clear
      ;;
    *)
      echo [ERROR] "$1" は設定されていない引数です。
      ;;
  esac
fi
