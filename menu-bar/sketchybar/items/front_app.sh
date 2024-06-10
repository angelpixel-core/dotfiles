#!/bin/bash

sketchybar --add item front_app left \
           --set front_app background.color="$SKETCHY_ACCENT_COLOR" \
                           icon.color="$SKETCHY_BAR_COLOR" \
                           icon.font="sketchybar-app-font:Regular:16.0" \
                           label.color="$SKETCHY_BAR_COLOR" \
                           script="$SKETCHY_PLUGINS_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
