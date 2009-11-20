#! /bin/bash
filename=${@##*/}
newfile="${filename%xml}""lua"
echo "$newfile"
xsltproc ./convert.xsl  "$2" | tee  "$1""$newfile" | lua
echo "--------"
