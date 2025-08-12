#!/bin/sh

selection=$(gopass list -f | wmenu -p "Search:" -l 10)
if [ -n "$selection" ]; then
  gopass show -c "$selection"
fi
