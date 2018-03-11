#!/bin/bash

# Functions to install mongo db

pushd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) > /dev/null
source textformatting.sh

function installMongoDb() {

  if [[ $(source installed.sh mongodb) == 'N' ]]; then
    echo $cyanfg"Installing Mongo" $resetall
    sudo apt-get update
    sudo apt-get install -y mongodb

    echo "${bold}${greenfg}To start mongodb : sudo service mongodb start" && echo ${resetall}
  else
    echo $cyanfg"MongoDb is already installed" $resetall
    dpkg -l mongodb
  fi
}

if [[ $(uppercase $1) == "INSTALL" ]]; then
  echo ${bold}${bluefg} &&   if [[ $(source enquirer.sh Install MongoDb) == 'Y' ]]; then
    echo ${resetall} && installMongoDb
  fi
fi

if [[ $(uppercase $1) == "UNINSTALL" ]]; then
  echo ${bold}${bluefg} &&  if [[ $(source enquirer.sh Uninstall MongoDb) == 'Y' ]]; then
    echo ${resetall} && sudo service mongodb stop && sudo apt-get remove --purge -y mongodb* && sudo apt-get autoremove
  fi
fi

if [[ $(uppercase $1) == "START" ]]; then
  sudo service mongodb start
fi

if [[ $(uppercase $1) == "STOP" ]]; then
  sudo service mongodb stop
fi

if [[ $(uppercase $1) == "RESTART" ]]; then
  sudo service mongodb restart
fi

if [[ $(uppercase $1) == "LOG" ]]; then
  #echo "${cyanfg}tail /var/log/mongodb/mongod.log${resetall}"
  set -x

  tail /var/log/mongodb/mongodb.log

  set +x
fi


if [[ $(uppercase $1) == "" ]]; then
  echo ${cyanfg}"Usage:
  mongo.sh [command]"
  echo "Commands :
  install
  uninstall
  start
  stop
  restart
  log" ${resetall}
fi

popd > /dev/null
