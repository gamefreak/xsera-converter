#! /bin/bash

mkdir -p ./temp
mkdir -p ./new
mkdir -p ./new/Actions
mkdir -p ./new/Objects
mkdir -p ./new/Races
mkdir -p ./new/Scenarios

find . -name *.xml -type f -print0 | xargs -n 1 -0 ./convert.sh 
#find ./new -name *.lua -type f -print0 | xargs -n 1 -0 lua 2>>err
#find ./temp -name *.lua -type f -print0 | xargs -n 1 -0 lua
#sleep 1
rmdir ./temp/