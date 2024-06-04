#!/bin/sh
export IFS=$'\t'
herbstclient --idle | while read -ra fields; do
    if [ "${fields[0]}" == "window_title_changed" -o "${fields[0]}" == "focus_changed" ]; then
        echo "${fields[2]}"
    fi
done

