#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname $0 )" && pwd )"

INSTALL_ARR=""


ask_to_install()
{
  APP=$1
  FILE=$2

  read -p "Do you want to install $APP? (Y/n): " ANS
  ANS=${ANS:-Y} # sets Y to be default value
  case $ANS in
    [yY]* ) # if first letter is y or Y (yes)
      INSTALL_ARR="${INSTALL_ARR} $FILE";;
    * ) # anything else
      ;;
  esac
}

ask_to_install "common_setup" common_setup.sh
ask_to_install "git_setup" git_setup.sh
ask_to_install "ros_noetic_setup" ros_noetic_setup.sh
ask_to_install "surface_setup" surface_setup.sh
