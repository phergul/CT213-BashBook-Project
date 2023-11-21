#!/bin/bash

dirPath="../Users"
pipeDir="./pipes"

#checks for the id being passed as an argument
if [ "$#" -ne 1 ]; then
	echo "ERROR: no identifier provided or too many arguments" >&2
	exit 1
fi

user_id="$1"

#checks if the user has a unique pipe and creates if not
#would only exist if user has 'logged in' before
if [ ! -p "$pipeDir/$user_id.pipe" ]; then
	mkfifo $pipeDir/$user_id.pipe
fi

#if the user doesnt exist calls create for them using a well formed request
if [ ! -d "$dirPath/Users/$user_id" ]; then
	echo "create" $user_id > $pipeDir/server.pipe
	read -r reply < "$pipeDir/$user_id.pipe"
fi

while [ true ];
do
	echo ""
	#reads command and the arguments needed
	read -p "Enter command: " request
	read -p "Enter Arguments: " args
	#send the request to the server pipe
	echo $request $user_id $args > $pipeDir/server.pipe
	
	#reads response from the server
	read -r response < "$pipeDir/$user_id.pipe"
	#takes the first letter of response (used to determine success or error)
	ok="${response:0:1}"
	#gets everything after ': ' in the response
	resMessage="${response#*: }"
	
	#based on if server responds with 'ok' or 'nok'
	case $ok in
		o)
			echo "SUCCESS: $resMessage"
			;;
		n)
			echo "ERROR: $resMessage"
			;;
		#special case for when displaying walls (first letter of response is s from start_of_file)
		s)
			echo ""
			#gets everything from after 'start_of_file' and before 'end_of_file'
			response=${response##*start_of_file}
			response=${response%%end_of_file}
			echo "$response"
			;;
		*)
			echo "Error receiving response from server"
			;;
	esac
done

exit 0
