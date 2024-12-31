#!/usr/bin/env bash
#
# Author: John Doe
# Description:
#   Concatenates content and filenames of multiple input files, folders, or glob patterns
#   and outputs the result. Each file's content is enclosed within backticks (`).
#   The filename is displayed before its content.

set -euo pipefail

function show_usage() {
  echo "Usage: $(basename "$0") [-n] [-a] <glob_pattern1> [<glob_pattern2> ...]"
  echo
  echo "Options:"
  echo "  -n, --no-paths    Disable printing file paths (print content only)."
  echo "  -a, --absolute    Use absolute file paths instead of relative paths."
}

function print_file_content() {
  local filename=$1
  local path content

  if [ "$print_paths" ]; then
    if [ "$use_absolute_paths" ]; then
      path=$(realpath "$filename")
    else
      path=$(realpath --relative-to="$PWD" "$filename")
    fi
    echo "$path:"
  fi

  content=$(<"$filename")
  echo -e "\`\`\`$content\`\`\`\n"
}

function copy_to_clipboard() {
  local clipboard_command=""
  if command -v pbcopy >/dev/null 2>&1; then
    clipboard_command="pbcopy" # macOS clipboard command
  elif command -v xclip >/dev/null 2>&1; then
    clipboard_command="xclip -selection clipboard" # Linux clipboard command
  else
    echo "Error: Clipboard functionality is not supported on this system."
    exit 1
  fi

  # Copy output to clipboard using the detected clipboard command
  cat | $clipboard_command
}

function concatenate_files_and_paths() {
  # nullglob prevents processing non-existent files and empty glob patterns.
  shopt -s nullglob

  for glob_pattern in "$@"; do
    files=("$glob_pattern")

    # Check if no files were found for the current glob pattern.
    if [ ${#files[@]} -eq 0 ]; then
      echo "No files found for pattern: $glob_pattern"
      exit 1
    fi

    for file in "${files[@]}"; do
      # Check if the file is a regular file before processing
      if [ -f "$file" ]; then
        print_file_content "$file"
      fi
    done
  done
}

function main() {
  local use_absolute_paths=""
  local print_paths="true"

  # Process options and remove them from the argument list
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -n | --no-paths)
      print_paths=""
      shift
      ;;
    -a | --absolute)
      use_absolute_paths="true"
      shift
      ;;
    *)
      break
      ;;
    esac
  done

  if [ $# -lt 1 ]; then
    show_usage
    exit 1
  fi

  concatenate_files_and_paths "$@" | copy_to_clipboard
}

main "$@"
