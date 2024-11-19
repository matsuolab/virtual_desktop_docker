#!/usr/bin/env bash

mkdir -p $HOME/.local/bin
curl -H 'Cache-Control: no-cache' "https://raw.githubusercontent.com/matsuolab/virtual_desktop_docker/refs/heads/master/rdp-ssh" \
--output "$HOME/.local/bin/rdp-ssh"
chmod +x $HOME/.local/bin/rdp-ssh


echo "Installation has finished!"
echo 'Verify that $HOME/.local/bin is in $PATH'

rdp-ssh -h
