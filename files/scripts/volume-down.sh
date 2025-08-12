#!/bin/sh
echo "Running volume-down.sh at $(date)" >> /tmp/dwl-script.log
echo "USER=$USER" >> /tmp/dwl-script.log
echo "PATH=$PATH" >> /tmp/dwl-script.log
exec pactl set-sink-volume @DEFAULT_SINK@ -5%
