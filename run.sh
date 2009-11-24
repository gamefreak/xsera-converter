#! /bin/bash

#$1 directory containing the xml
#$2 directory that the lua will go into

mkdir -p $2
echo "return {" > $2/data.lua
for dir in Actions InitialObject Objects Races Scenarios
do
echo "$dir"
mkdir -p "$2$dir"
./convert.sh "$1$dir" "$2$dir"
echo "[\"$dir\"] = {" > "$2/$dir.lua"
cat $2$dir/* >> "$2/$dir.lua"
echo "};" >> "$2/$dir.lua"
cat $2/$dir.lua >> $2/data.lua
done

echo "};" >> $2/data.lua

lua $2/data.lua
