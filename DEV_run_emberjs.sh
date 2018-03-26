#!/bin/bash
function die(){
   echo ${1:=Something terrible wrong happen}
   exit 1
}

step="build emberjs/github-fastboot-example"
echo "* $step"
cd gk_prototype/emberjs/github-fastboot-example/ && ./DEV_build.sh && cd ../../.. || die "error while $step"

step="deploy emberjs/github-fastboot-example"
echo "* $step"
cd env && ./emberjs_promote.sh && ./launch.sh && cd ../ || die "error while $step"