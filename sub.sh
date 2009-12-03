#! /bin/bash
filename=${2##*/}
echo "$filename"
newfile="${filename%xml}""lua"
#echo "$1/""$newfile"
num=`echo "$newfile" | sed -e "s/[ \.].*//"`
echo -n "[$num] = " > "$1/""$newfile" 
xsltproc ./convert.xsl  "$2" >> "$1/""$newfile"

