#!/bin/sh
volume="$(pamixer --get-volume-human)"

if [ "$volume" = "muted" ]; then
	echo ""
else 
	echo " $volume"
fi
