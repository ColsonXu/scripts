#!/bin/bash

sink_list=($(pactl list short sinks | awk '{print $1}'))
num_of_sinks=${#sink_list[@]}

if [ $num_of_sinks -eq 0 ]; then
    exit 1
fi

new_index=1
if [ -f ~/scripts/current_sink_index ]; then
    curr_index=$(< $HOME/scripts/current_sink_index)
    new_index=$(((curr_index + 1) % num_of_sinks))
fi

echo $new_index > $HOME/scripts/current_sink_index

pactl set-default-sink ${sink_list[$new_index]}

