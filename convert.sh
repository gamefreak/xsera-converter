#! /bin/bash
echo $1
mkdir ./temp
f=./temp/${1//*\//}
	
rm "$f"
cp "$1" "$f"

sed -f ./converter.sed <"$f" >"$f"2

tr "\n" ' ' <"$f"2 >./"$f"3
sed -e 's|,[^,]*$||' <"$f"3 >"$f"4
! lua <"$file"4 2>>err && echo "$file">>err

#rm "$f"*
rmdir ./temp