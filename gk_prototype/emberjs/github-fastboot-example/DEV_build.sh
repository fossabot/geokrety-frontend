#!/bin/bash
function die(){
   echo ${1:=Something terrible wrong happen}
   exit 1
}

# echo "npm install double check"
# npm install || die "Unable to execute requirement 'npm install'"

echo "clean dist/"
mkdir -p dist/ && rm -rf dist/*

echo "ember build"
ember build || die "Unable to execute 'ember build'"
# ember build --environment production

echo "dist/ done"