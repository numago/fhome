#!/usr/bin/env bash
#
# Kills the process running on the provided port

port_number="$1"

if [[ -z "$port_number" || ! "$port_number" =~ ^[0-9]+$ ]]; then
	echo "Usage: $(basename "$0") <port_number>"
	exit 1
fi

# Get the PID of the process using the specified port
process_id=$(lsof -ti:"$port_number" 2>/dev/null)

if [ -z "$process_id" ]; then
	echo "No process found on port $port_number"
	exit 1
fi

echo "Process ID: $process_id"
echo "Command: $(ps -p "$process_id" -o cmd=)"
read -rp "Are you sure you want to kill this process? (y/n): " choice

case "$choice" in
[Yy]*)
	if [ "$(id -u)" -ne 0 ]; then
		sudo kill "$process_id"
	else
		kill "$process_id"
	fi
	;;
*)
	echo "Process not killed. Exiting..."
	exit 0
	;;
esac
