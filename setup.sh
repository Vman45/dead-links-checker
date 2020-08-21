#!/bin/bash

### This file contains the commands for installing Dart for the first time.   ###
### It only has to run once, though it will check if Dart is already present. ###
### Needs sudo to apt-get install, though sudo apt-get fails on some machines ###
### Refer to https://www.dartlang.org/tools/sdk#install under the Linux tab.  ###
### Don't put this in crontab. It's one-time setup, no need to run regularly. ###

dart &> /dev/null ; result=$?
#var is 255 if dart is found, 127 if not found.
if [ "$result" == 127 ] ; then
    echo "Dart is not yet installed."
    sudo apt-get update
    sudo apt-get install apt-transport-https
    sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
    sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
    sudo apt-get update
    sudo apt-get install dart
else
    echo "Dart is already installed."
fi