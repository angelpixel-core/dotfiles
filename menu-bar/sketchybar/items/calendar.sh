#!/bin/bash

sketchybar --add item calendar left \
           --set calendar icon=􀧞  \
                          update_freq=5 \
                          script="$SKETCHY_PLUGINS_DIR/calendar.sh"

