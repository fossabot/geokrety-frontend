#!/bin/bash
function die(){
   echo ${1:=Something terrible wrong happen}
   exit 1
}

currentDirectory=$(pwd)
prototypeDirectory=gk_prototype/emberjs/github-fastboot-example/

# you could uncomment this to execute setup first time 
# todo: add shell arg to drive that
# step="setup $prototypeDirectory"
# echo "* $step"
# cd "$prototypeDirectory" && ./DEV_setup.sh && cd "$currentDirectory" || die "error while $step"

step="build $prototypeDirectory"
echo "* $step"
cd "$prototypeDirectory" && ./DEV_build.sh && cd "$currentDirectory" || die "error while $step"

step="deploy $prototypeDirectory"
echo "* $step"
cd "env/" && ./emberjs_promote.sh && ./launch.sh && cd "$currentDirectory" || die "error while $step"