#!/bin/bash

# Get regular windows
regular_windows=$(swaymsg -t get_tree | jq -r '.nodes[].nodes[].nodes[] | .. | (.id|tostring) + " " + .name?' | grep -e "[0-9]* ."  )

# Get floating windows
floating_windows=$(swaymsg -t get_tree | jq '.nodes[].nodes[].floating_nodes[] | (.id|tostring) + " " + .name?'| grep -e "[0-9]* ." | tr -d '"')

if [[ $regular_windows && $floating_windows ]]; then
  all_windows="$regular_windows\n$floating_windows"
elif [[ $regular_windows ]]; then
  all_windows=$regular_windows
else
  all_windows=$floating_windows
fi

# Select window with rofi
selected=$(echo "$all_windows" | wofi -dmenu | awk '{print $1}')

# Tell sway to focus said window
swaymsg [con_id="$selected"] focus
