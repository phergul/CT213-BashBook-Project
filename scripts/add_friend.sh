#!/bin/bash

dirPath="../Users"
user_id="$1"
friend="$2"

#check if correct number of arguments passed, making sure they are unique
if [ "$#" -ne 2 ] || [ "$user_id" = "$friend" ]; then
	echo "nok: cannot add self" >&1
	exit 1
#check whether the users that are passed in exist as directories
#error 1 from assignment pdf
elif [ ! -d "$dirPath/$user_id" ]; then
	echo "nok: user '$user_id' does not exist" >&1
	exit 1
#error 2 from assignment pdf
elif [ ! -d "$dirPath/$friend" ]; then
	echo "nok: user '$friend' does not exist" >&1
	exit 1
fi

#check whether the two passed users are already friends (symmetric check)
#this exits with 0 as the friends are added
if grep "$friend" "$dirPath/$user_id/friends.txt" > /dev/null; then
	echo "nok: $user_id already has friend $friend" >&1
	exit 0
elif grep "$user_id" "$dirPath/$friend/friends.txt" > /dev/null; then
	echo "nok: $friend already has friend $user_id" >&1
	exit 0
fi

#adds friends to each others friends.txt list
echo "$friend" >> "$dirPath/$user_id/friends.txt"
echo "$user_id" >> "$dirPath/$friend/friends.txt"
echo "ok: friend added!" >&1

exit 0
