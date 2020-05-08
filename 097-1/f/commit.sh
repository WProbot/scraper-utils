#!/bin/bash


  fossil set repo-cksum     1
  fossil set autosync       1
  fossil set manifest       0
  fossil set mtime-changes  0
  fossil set allow-symlinks 1


  fossil addr  --dotfiles --ignore "*/.git/*"

  fossil commit -m $(hostname) --no-warnings --allow-fork

