#! /bin/bash
n=${1//*\//}
f=./temp/$n

pretty="true"

cp "$1" "$f"
sed -e "s|\(\"[^\"]*\), \([^\"]*\"\)|\1\s\2|g" <"$f" >"$f"1
sed -f ./converter.sed <"$f"1 >"$f"2

tr "\n" ' ' <"$f"2 >"$f"3
sed -e 's|,[^,]*$||' <"$f"3 >"$f"4

cp "${f}4" "./${f/xml/lua}"
lua "./${f/xml/lua}" 2>>err && echo "$n OK"

if [ "$pretty" == "true" ]
then
	lua -e "dofile('${f/xml/lua}'); function run() persistence.store('./new/${1/xml/lua}',"`sed -e "s|^\([a-z0-9_\-]*\).*|\1|" <"${f/xml/lua}"`") end" ./pretty.lua
	rm "${f/xml/lua}"
else
	mv "${f/xml/lua}" "./new/${1/xml/lua}"
fi

rm "$f"
rm "$f"[12345]


