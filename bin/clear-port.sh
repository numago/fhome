#!/usr/bin/env bash
#
# Kills the process running on the provided port

if [[ -z "$1" || ! "$1" =~ ^[0-9]+$ ]]; then
	echo "Usage: $(basename "$0") <port_number>"
	exit 1
fi

port_number="$(lsof -ti:"$1" 2>/dev/null)"

if [ -z "$port_number" ]; then
	echo "No process found on port $1"
	exit 1
fi

kill "$port_number"
