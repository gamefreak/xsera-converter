#! /bin/bash
dirname=${2##.*/}
number=${dirname%% *}
name=${dirname#* }
echo $dirname
n=`ls -1 "$2" | wc -l`
n=${n##* }
case "$n" in 
	1) dim=1x1;;
	3) dim=3x1;;
	5) dim=5x1;;
	6) dim=3x2;;
	7) dim=7x1;;
	8) dim=4x2;;
	9) dim=3x3;;
	12) dim=4x3;;
	15) dim=5x3;;
	21) dim=7x3;;
	24) dim=6x4;;
	25) dim=5x5;;
	27) dim=9x3;;
	28) dim=7x4;;
	29) dim=29x1;;
	36) dim=6x6;;
esac
montage "$2/*.png" -tile $dim -geometry +0+0 -background transparent "$1"/Sprites/$number.png
echo "[$number] = \"$name\";" >> $1/Sprites.lua

cat > $1/Sprites/$number.xml <<EOF
<?xml version="1.0"?>
<sprite>
	<dimensions x="${dim%x*}" y="${dim#*x}" />
	<rotational />
	<scale factor="1.0" />
</sprite> 
EOF
