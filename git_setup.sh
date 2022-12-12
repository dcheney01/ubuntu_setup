#!/bin/sh

USER_EMAIL = daniel.cheney01@gmail.com

# Git Setup
sudo apt-get install -y git
git config --global core.editor nano #NOTE: change this if you are anti-emacs
git config --global color.ui True
git config --global push.default simple

git config --global user.name "Daniel Cheney"
git config --global user.email $USER_EMAIL

git config --global --add merge.tool kdiff3
git config --global --add mergetool.kdiff3.trustExitCode false
git config --global --add diff.guitool kdiff3
git config --global --add difftool.kdiff3.trustExitCode false

if [ ! -f /usr/bin/ssh ]; then
    echo_blue "Installing ssh"
    sudo apt install -y ssh
    echo_green "ssh installed"
fi

echo_blue "Setting up ssh key"

if [ -f ~/.ssh/id_ed25519 ]; then
    echo_blue "Found an existing ed25519 ssh key"
else
    if [ -f ~/.ssh/id_rsa ]; then
	    echo_blue "Old rsa key type exists (Recommended to use ed25519)"
    fi
    echo_blue "Creating new ed25519 ssh key"
    echo "Enter git email (can leave empty): \c"
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "$USER_EMAIL"
    echo_blue "Adding ssh key to ssh agent"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo_green "ssh key created and added to ssh agent"
fi

if [ -f /usr/bin/xclip ]; then
    xclip -sel clip < ~/.ssh/id_ed25519.pub
    echo_blue "ssh key has been copied to clipboard"
    echo_purple "Go add key to github and bitbucket"
else
    echo_purple "Copy ~/.ssh/id_ed25519.pub contents to your git servers"
fi

read -p "Press ENTER to continue..." _