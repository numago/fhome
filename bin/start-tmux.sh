#!/usr/bin/env bash
#
# Author: Fred Okoro
# Description:
#   Start tmux in interactive shell

tmux_exists() {
	command -v tmux &>/dev/null
}

is_interactive_shell() {
	[ -n "$PS1" ]
}

not_in_tmux_session() {
	[ -z "$TMUX" ]
}

if tmux_exists && is_interactive_shell && not_in_tmux_session; then
	exec tmux
fi
