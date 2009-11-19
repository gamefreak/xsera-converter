#! /bin/bash

if [ -n "$1" ]
then
	prefix=$1
else
	prefix="."
fi

#if [ -n "$2" ]
#then
#        fname=$2
#else
#	fname="*.xml"
#fi

find $prefix -name $fname -type f -print0 | xargs -n 1 -0 xsltproc ./convert.xsl
