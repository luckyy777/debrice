#!/bin/sh
echo " $(nmcli device | grep 'wifi ' | awk '{print $4}')"
