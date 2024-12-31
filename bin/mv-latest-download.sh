#!/usr/bin/env bash

downloads_dir="${HOME}/Downloads"

usage() {
	echo "Moves the latest file from the Downloads directory to the specified target"
	echo
	echo "Usage:"
	echo "$(basename "$0") [target_directory_or_file]"
	echo
	echo "Notes:"
	echo "If no target is provided, the current directory is used."
	echo "Confirmation will be requested before overwriting any existing files."
	exit 1
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
fi

if [ ! -d "${downloads_dir}" ]; then
	echo "Error: Downloads directory does not exist."
	exit 1
fi

latest_file=$(find "${downloads_dir}" -type f -printf '%T@ %p\n' | sort -nr | head -n 1 | cut -f2- -d' ')

if [ -z "${latest_file}" ]; then
	echo "Error: No files found in ${downloads_dir}."
	exit 1
fi

target="." # target directory or file

if [ $# -gt 1 ]; then
	usage
elif [ $# -eq 1 ]; then
	target="$1"
fi

# --interactive: prompt before overwriting
if mv --interactive "$latest_file" "$target"; then
	echo "Moved $(basename "$latest_file") to $target"
else
	echo "Error: Failed to move $(basename "$latest_file") to $target"
	exit 1
fi
