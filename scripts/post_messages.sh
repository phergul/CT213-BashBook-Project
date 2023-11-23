#!/bin/bash

dirPath="../Users"
lockDir="./locks"
sender="$1"
receiver="$2"

#checks whether there is enough arguments for sender, receiver and message
if [ "$#" -lt 3 ]; then
	echo "nok: Script requires at least 3 arguments 'sender', 'receiver' and 'message'" > /dev/null
	exit 1
#same as add_friend.sh, checks for the existance of the sender and receiver
elif [ ! -d "$dirPath/$sender" ]; then
	echo "nok: user '$sender' does not exist" >&1
	exit 1
elif [ ! -d "$dirPath/$receiver" ]; then
	echo "nok: user '$receiver' does not exist" >&1
	exit 1
#this check allows a person to post on their own page (to reply i guess)
elif [ "$sender" != "$receiver" ]; then
	#runs if sender and receiver are unique users
	#checks if they are friends (friendships are symmetrical)
	if ! grep "$sender" "$dirPath/$receiver/friends.txt" > /dev/null; then
		echo "nok: user '$sender' is not a friend of '$receiver'" >&1
		exit 1
	fi
fi

./acquire.sh "$lockDir/post_message_lock"

#shifts 2 arguments to not add sender and receiver id to message
shift 2
#$* is the same as #@ but is just one string not array of the arguments
message="$*"

#prints who the sender is and the message to the receivers wall.txt
echo "$sender: $message" >> "$dirPath/$receiver/wall.txt"
./release.sh "$lockDir/post_message_lock"

echo "ok: message posted!" >&1
exit 0
