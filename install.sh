#!/bin/bash

curl -o "/usr/local/bin/git-scroll.sh" "https://raw.githubusercontent.com/polatengin/skopje/main/main.sh"

chmod +x "/usr/local/bin/git-scroll.sh"

sudo apt-get update
sudo apt-get install -y curl jq awk

{
  echo 'alias git-scroll="/usr/local/bin/git-scroll.sh"'
  echo 'alias gs="/usr/local/bin/git-scroll.sh"'
} >> ~/.bashrc

source ~/.bashrc
