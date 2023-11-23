#!/bin/bash

dirPath="../Users"
lockDir="./locks"
user_id="$1"

#checks if there is only 1 arguments ('$id')
if [ "$#" -ne 1 ]; then
	echo "nok: no identifier provided or too many arguments" > /dev/null
	exit 1
#checks whether that user exists for given id
elif [ ! -d "$dirPath/$user_id" ]; then
	echo "nok: user '$user_id' does not exist" >&1
	exit 1
fi

./acquire.sh "$lockDir/display_wall_lock"

#prints start, wall.txt and end for the given user_id
userWall="start_of_file$(cat "$dirPath/$user_id/wall.txt")end_of_file"
echo "$userWall"

./release.sh "$lockDir/display_wall_lock"

exit 0
