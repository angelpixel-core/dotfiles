#!/bin/bash

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

# TODO: extract into some zsh init
ICONS_PLUGIN_DIR="$HOME/.config/sketchybar/plugins/icon_map_fn.sh"

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" \
                   label="$INFO" \
                   icon="$($ICONS_PLUGIN_DIR $INFO)"
fi


