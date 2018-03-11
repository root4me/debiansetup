#!/bin/bash

# Functions to install keepassxc

pushd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) > /dev/null
source textformatting.sh

function installKeePassX() {

  if [[ $(source installed.sh keepassxc) == 'N' ]]; then
    echo $cyanfg "Installing KeePassXc" $resetall &&  sudo apt-get install keepassxc
  else
    echo $cyanfg"KeePassXc is already installed" $resetall
    dpkg -l keepassxc
  fi
}

if [[ $(uppercase $1) == "INSTALL" ]]; then
  echo ${bold}${bluefg} &&   if [[ $(source enquirer.sh Install keepassxc) == 'Y' ]]; then
    echo ${resetall} && installKeePassX
  fi
fi

if [[ $(uppercase $1) == "UNINSTALL" ]]; then
  echo ${bold}${bluefg} &&  if [[ $(source enquirer.sh Uninstall git) == 'Y' ]]; then
    echo ${resetall} && sudo apt-get remove --purge -y keepassxc
  fi
fi

if [[ $(uppercase $1) == "" ]]; then
  echo ${cyanfg}"Usage:
  keepassx.sh [command]"
  echo "Commands :
  install
  uninstall" ${resetall}
fi

popd > /dev/null
