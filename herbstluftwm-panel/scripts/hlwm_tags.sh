#!/bin/sh

{ echo; herbstclient --idle; } | while read line; do
    echo -n '{'
    for monitor in general_main general_side other_main other_side work_main work_main2 work_side; do
        if [ "$monitor" == "general_main" ]; then
            echo -n "\"$monitor\":{"
        else
            echo -n ",\"$monitor\":{"
        fi
        IFS=$'\t' read -ra tags <<<"$(herbstclient tag_status $monitor)"
        for i in "${tags[@]}"; do
            if [ "$i" == "$tags" ]; then
                echo -n "\"${i:1}\":{\"status\":"
            else
                echo -n ",\"${i:1}\":{\"status\":"
            fi
            case ${i:0:1} in
                '#')
                    echo -n '"focused"'
                    ;;
                '+')
                    echo -n '"focused_this_monitor_unfocused"'
                    ;;
                '-')
                    echo -n '"focused_other_monitor_unfocused"'
                    ;;
                '%')
                    echo -n '"focused_other_monitor_focused"'
                    ;;
                ':')
                    echo -n '"nonempty"'
                    ;;
                '!')
                    echo -n '"urgent"'
                    ;;
                *)
                    echo -n '"empty"'
                    ;;
            esac
            echo -n '}'
        done
        echo -n '}'
    done
    echo '}'
done
