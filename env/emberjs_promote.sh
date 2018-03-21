#!/bin/bash
function die(){
   echo ${1:=Something terrible wrong happen}
   exit 1
}
DIST_DIR=../gk_prototype/emberjs/github-fastboot-example/dist
PROMOTE_TARGET=./exposed/www/
echo "promote dist (${DIST_DIR}) to target directory (${PROMOTE_TARGET})"
rm -rf $PROMOTE_TARGET \
 && mkdir -p $PROMOTE_TARGET \
 && cp -r $DIST_DIR/* $PROMOTE_TARGET || exit 1

echo "emberjs promoted. Next step: ./launch.sh"
