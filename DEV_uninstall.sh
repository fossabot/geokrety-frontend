#!/bin/bash
function die(){
   echo ${1:=Something terrible wrong happen}
   exit 1
}

currentDirectory=$(pwd)
step="undeploy"
echo "* $step"
cd "env/" && ./launch.sh revert && cd "$currentDirectory" || die "error while $step"