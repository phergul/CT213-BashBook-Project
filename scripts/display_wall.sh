#!/bin/bash

dirPath="../Users"
user_id="$1"

#checks if there is only 1 arguments ('$id')
if [ "$#" -ne 1 ]; then
	echo "nok: no identifier provided or too many arguments" > /dev/null
	exit 1
#checks whether that user exists for given id
elif [ ! -d "$dirPath/$user_id" ]; then
	echo "nok: user '$user_id' does not exist" >&2
	exit 1
fi

#prints start, wall.txt and end for the given user_id
echo "start_of_file"
cat $dirPath/$user_id/wall.txt
echo "end_of_file"

exit 0
