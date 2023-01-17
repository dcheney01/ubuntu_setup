#!/bin/sh

# Git Setup
$USER_EMAIL = daniel.cheney01@gmail.com

sudo apt-get install -y git
git config --global core.editor nano
git config --global color.ui True
git config --global push.default simple

git config --global user.name "Daniel Cheney"
git config --global user.email "daniel.cheney01@gmail.com"

git config --global --add merge.tool kdiff3
git config --global --add mergetool.kdiff3.trustExitCode false
git config --global --add diff.guitool kdiff3
git config --global --add difftool.kdiff3.trustExitCode false

if [ ! -f /usr/bin/ssh ]; then
    sudo apt install -y ssh
fi

if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "Enter git email (can leave empty): \c"
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "$USER_EMAIL"
    
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
fi

if [ -f /usr/bin/xclip ]; then
    xclip -sel clip < ~/.ssh/id_ed25519.pub
    echo "ssh key has been copied to clipboard. Go add key to github and bitbucket"

fi
