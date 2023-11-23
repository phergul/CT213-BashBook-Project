#!/bin/bash

dirPath="../Users"
lockDir="./locks"
user_id="$1"

#check if there is one parameter for $user_id
if [ "$#" -ne 1 ]; then
	echo "nok: no identifier provided or too many arguments" >&2
	exit 1
fi

./acquire.sh "$lockDir/create_lock"

#check there is a Users directory in the first place
if [ ! -d "$dirPath" ]; then
	mkdir "$dirPath"
fi
#check whether a directory for the user already exists
if [ -d "$dirPath/$user_id" ]; then
	echo "nok: user already exists" >&1
	./release.sh "$lockDir/create_lock"
	exit 2
else
	mkdir "$dirPath/$user_id"
fi

#creates a directory for the given $user_id and adds both necessary files to it
echo -n > "$dirPath/$user_id"/friends.txt
echo -n > "$dirPath/$user_id"/wall.txt

./release.sh "$lockDir/create_lock"

echo "ok: user created!" >&1
exit 0
