#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$SKETCHY_PLUGINS_DIR/volume.sh" \
           --subscribe volume volume_change 


