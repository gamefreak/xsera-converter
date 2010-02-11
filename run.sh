#! /bin/bash

#$1 directory containing the xml
#$2 directory that the lua will go into

mkdir -p $2
echo "return {" > $2/data.lua

#convert the XML
for dir in Actions InitialObject Objects Races Scenarios Conditions
do
echo "$dir"
mkdir -p "$2$dir"
./convert.sh "$1$dir" "$2$dir"
echo "[\"$dir\"] = {" > "$2/$dir.lua"
cat $2$dir/* >> "$2/$dir.lua"
echo "};" >> "$2/$dir.lua"
cat $2/$dir.lua >> $2/data.lua
done


#convert sprites
mkdir -p $2/Sprites
echo "[\"Sprites\"] = {" > $2/Sprites.lua
find $1/Sprites/ -depth 1 -type d -print0 | xargs -0 -n 1 ./sprites.sh $2
echo "};" >> $2/Sprites.lua

cat $2/Sprites.lua >> $2/data.lua
echo "};" >> $2/data.lua

lua $2/data.lua
