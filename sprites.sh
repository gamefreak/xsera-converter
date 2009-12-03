#! /bin/bash
dirname=${2##.*/}
number=${dirname%% *}
name=${dirname#* }
echo $dirname
montage "$2"/*.png -geometry +0+0 -background transparent $1/Sprites/$number.png
echo "[$number] = \"$name\";" >> $1/Sprites.lua
