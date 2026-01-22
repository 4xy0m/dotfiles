#!/usr/bin/env zsh

if [ -f .envrc ]; then
  direnv exec . nvim
else
  nvim
fi
