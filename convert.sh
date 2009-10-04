#! /bin/bash

f=./temp/${1//*\//}
	
cp "$1" "$f"
sed -e "s|\(\"[^\"]*\), \([^\"]*\"\)|\1\s\2|g" <"$f" >"$f"1
sed -f ./converter.sed <"$f"1 >"$f"2

tr "\n" ' ' <"$f"2 >"$f"3
sed -e 's|,[^,]*$||' <"$f"3 >"$f"4
#sed -e 's|, |,\
#|g' <"$f"4 >"$f"5
cp "${f}4" "./${f/xml/lua}"
lua "./${f/xml/lua}" 2>>err && echo "OK"

rm "$f"
rm "$f"[12345]

