#!/bin/sh

# # If using Surface Laptop
# There is an authorization issue, the following should fix it
sudo add-apt-repository ppa:gpxbv/apt-urlfix
sudo apt-get -y update
sudo apt-get -y install apt


wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \
    | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg
echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" \
	| sudo tee /etc/apt/sources.list.d/linux-surface.list
sudo apt-get update
sudo apt-get -y install linux-image-surface linux-headers-surface iptsd libwacom-surface
sudo systemctl enable iptsd # Enables touchscreen support

sudo apt-get -y install linux-surface-secureboot-mok
sudo update-grub # updates boot loader to use surface kernel
