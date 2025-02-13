#!/usr/bin/env bash
zellij action move-focus right
zellij action write 27 # send <Escape> key
zellij action write-chars ":$1 $2"
zellij action write 13 # send <Enter> key
