#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage $0 mutex-name" >&1
	exit 1
else
	while ! ln "$0" "$1" 2>/dev/null; do
		sleep 1
	done

	exit 0
fi
