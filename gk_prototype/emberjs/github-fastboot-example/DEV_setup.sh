#!/bin/bash
# to run only one time
echo "install ember-cli"
npm install ember-cli -g
echo "npm install"
if [ ! -d node_modules/ ]; then
  echo "first time: about 16 min and 380 Mo (disk storage) for node_modules ..."
fi
npm install
