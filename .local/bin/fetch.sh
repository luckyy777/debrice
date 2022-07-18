#!/bin/sh

title="$(cat /etc/os-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/"//g')"
kernel="$(uname -r)"
shell="$SHELL"
packages="$(pacman -Qq | wc -l)"

echo "$title"
echo "$kernel"
echo "$SHELL"
echo "$packages"
