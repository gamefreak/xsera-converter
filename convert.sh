#! /bin/bash

#mkdir ./temp
f=./temp/${1//*\//}
	
cp "$1" "$f"
sed -f ./converter.sed <"$f" >"$f"2

tr "\n" ' ' <"$f"2 >"$f"3
sed -e 's|,[^,]*$||' <"$f"3 >"$f"4
lua <"$f"4 2>>err && cp "${f}4" "./${f/xml/lua}"

rm "$f"
rm "$f"[1234]

#rmdir ./temp