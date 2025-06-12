#!/bin/bash

if [ $# = 0 ]; then
  nvim ~/memo/memo.md
else 
  nvim ~/memo/$1.md
fi
