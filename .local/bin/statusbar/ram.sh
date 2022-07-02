#!/bin/sh
echo " $(free -h | grep Mem | awk '{print $3}' | sed 's/Gi/gb/g' | sed 's/Mi/mb/g')"
