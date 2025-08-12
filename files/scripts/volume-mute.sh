#!/bin/sh
exec pactl set-sink-mute @DEFAULT_SINK@ toggle
