#!/bin/sh
temp="$(sensors | grep "CPU" | awk '{printf $2 "\n"}' | sed 's/+//g' | sed 's/.0//g')"
echo " $temp"
