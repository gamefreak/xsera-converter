#! /bin/bash
filename=${@##*/}
#echo "$2"
#echo "$1""$filename"
newfile="${filename%xml}""lua"
#echo "$newfile"
#echo "------"
xsltproc ./convert.xsl  "$2" | tee  "$1""$newfile" | lua
