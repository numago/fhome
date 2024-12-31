#!/usr/bin/env bash

file_path=$(find . -type f -printf '%T@ %p\0' | sort -zn | tail -zn1 | cut -dz -f2-)
echo "$file_path"
