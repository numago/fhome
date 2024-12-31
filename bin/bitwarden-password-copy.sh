#!/usr/bin/env bash
#
# Author: John Doe
# Description:
#   Script to copy Bitwarden password to clipboard using rbw and xclip/pbcopy
#   The password is automatically removed from the clipboard after 20 seconds

clipboard_operation() {
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		xclip -selection clipboard <<<"$1"
		(sleep 20 && xclip -selection clipboard -r </dev/null) &
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		pbcopy <<<"$1"
		(sleep 20 && pbcopy </dev/null) &
	fi
}

selected_entry=$(rbw list --fields name,user,id,folder | fzf)
IFS=$'\t' read -r name user id <<<"$selected_entry"

password=$(rbw get "$id" 2>/dev/null)

if [[ -z $password ]]; then
	echo -e "Failed to retrieve password for:\n'$selected_entry'"
	exit 1
fi

clipboard_operation "$password"
echo -e "✔ Copied password for user \e[1m$user\e[0m, at $name"
