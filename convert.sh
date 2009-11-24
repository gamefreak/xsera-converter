#! /bin/bash

if [ -n "$1" ]
then
	prefix=$1
else
	prefix="."
fi

if [ -n "$2" ]
then
t=$2
else
t=/dev/null
fi

find $prefix -name *.xml -type f -print0 | xargs -n 1 -0 ./sub.sh $t

