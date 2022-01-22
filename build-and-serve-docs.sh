#!/bin/bash

lxc exec pab -- sudo --login --user nix bash -ilc "cd /home/nix/pab && nix-shell --command 'build-and-serve-docs'"
