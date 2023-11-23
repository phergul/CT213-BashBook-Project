#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage $0 mutex-name" >&1
	exit 1
else
	rm "$1"
	exit 0
fi
