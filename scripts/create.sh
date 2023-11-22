#!/bin/bash

dirPath="../Users"
user_id="$1"

#check there is a Users directory in the first place
if [ ! -d "$dirPath" ]; then
	mkdir "$dirPath"
fi

#check if there is one parameter for $user_id
if [ "$#" -ne 1 ]; then
	echo "nok: no identifier provided or too many arguments" >&2
	exit 1
#check whether a directory for the user already exists
elif [ -d "$dirPath/$user_id" ]; then
	echo "nok: user already exists" >&1
	exit 2
fi

#creates a directory for the given $user_id and adds both necessary files to it
mkdir "$dirPath/$user_id"
echo -n > "$dirPath/$user_id"/friends.txt
echo -n > "$dirPath/$user_id"/wall.txt

echo "ok: user created!" >&1
exit 0
