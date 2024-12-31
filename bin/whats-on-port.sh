#!/usr/bin/env bash
#
# List process running on provided port

if [[ -z "$1" || ! "$1" =~ ^[0-9]+$ ]]; then
	echo "Usage: $(basename "$0") <port_number>"
	exit 1
fi

lsof -ni:"$1"
