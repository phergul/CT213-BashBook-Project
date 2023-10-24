#!/bin/bash

dirPath="../Users"

while [ true ];
do
	echo ""
	read -p "Enter command: " request
	case $request in
		create)
			read -p "Enter id for user: " user_id
			./create.sh "$user_id"
			;;
		add)
			read -p "Enter id and then friend to add: " user_id friend
			./add_friend.sh "$user_id" "$friend"
			;;
		post)
			read -p "Enter sender, receiver then message: " sender receiver message
			./post_messages.sh "$sender" "$receiver" "$message"
			;;
		display)
			read -p "Enter id of user to display: " user_id
			echo ""
			./display_wall.sh "$user_id"
			;;
		*)
			echo "nok: bad request" >&2
			echo "Available Commands = {create | add | post | display}"
			exit 1
			;;
	esac
done

exit 0
