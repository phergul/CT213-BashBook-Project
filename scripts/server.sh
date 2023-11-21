#!/bin/bash

dirPath="../Users"
pipeDir="./pipes"

#checks if the server pipe exists and creates if not
if [ ! -p "$pipeDir/server.pipe" ]; then
	mkfifo $pipeDir/server.pipe
fi

while [ true ];
do
	#reads in a request from the server pipe
	read -r request < "$pipeDir/server.pipe"
	#assigns variable for each part of the request using the delimiter ' '
	IFS=' ' read -r command user_id args <<< "$request"
	
	#server always sends the response to the calling users pipe
	case $command in
		#runs when client.sh starts up
		create)
			./create.sh "$user_id" > "$pipeDir/$user_id.pipe"
			;;
		add)
			#args in this case is the name of the friend to add
			./add_friend.sh "$user_id" "$args" > "$pipeDir/$user_id.pipe"
			;;
		post)
			#splits the string to get receiver and message
			# %% takes the word before the first space
			receiver="${args%% *}"
			# the # takes everything after the first space
			message="${args#* }"
			./post_messages.sh "$user_id" "$receiver" "$message" > "$pipeDir/$user_id.pipe"
			;;
		display)
			./display_wall.sh "$args"  > "$pipeDir/$user_id.pipe"
			;;
		*)
			echo "nok: bad request - Available Commands = {add | post | display}" > "$pipeDir/$user_id.pipe"
			;;
	esac
done

exit 0
