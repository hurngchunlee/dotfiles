#!/bin/bash

#----------------------------------------------------------------------------------------------
# function to select a display port with a connected display.
#----------------------------------------------------------------------------------------------
function rofi_connected_display_selector() {
    xrandr | awk '$2 ~ /^connected/ {print $1}' | rofi -dmenu -p "select display port"
}

#----------------------------------------------------------------------------------------------
# function to select display mode (i.e. resolution and refresh rate).
#
#
# args:
#   1: display name
#----------------------------------------------------------------------------------------------
function rofi_display_mode_selector() {
    display=$1
    xrandr | \
      awk -v monitor="^$display connected" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | \
      grep -v $display | \
      awk '$1 ~ /[0-9]*x[0-9]*/ {res=$1; $1=""; sub(/^[ \t]+/, ""); sub(/[ \t][+*]/, ""); for(i=1; i<=NF; i++) print res":"$i}' | \
      rofi -dmenu -p "resolution and rate for display on $1"
}

#----------------------------------------------------------------------------------------------
# function to select external display relation to the primary display.
#----------------------------------------------------------------------------------------------
function rofi_display_relation() {
    printf "mirror\nextend:top\nextend:bottom\nextend:left\nextend:right" | rofi -dmenu -p "relation to the primary display"
}

#----------------------------------------------------------------------------------------------
# function to get the name of the primary display.
#----------------------------------------------------------------------------------------------
function primary_display() {
    xrandr --query | grep ' connected ' | grep ' primary ' | awk '{print $1}'
}

#----------------------------------------------------------------------------------------------
# function to check if given display is set as the primary display.
#
#
# args:
#   1: display name
#----------------------------------------------------------------------------------------------
function is_primary() {
    display=$1
    xrandr | awk -v display="^$display" '$1 ~ display {print $0}' | grep primary >/dev/null 2>&1
    return $?
}

#----------------------------------------------------------------------------------------------
# function to get the names of the connected external (i.e. non-primary) displays.
#----------------------------------------------------------------------------------------------
function connected_external_displays() {
    xrandr --query | grep ' connected ' | grep -v ' primary ' | awk '{print $1}'
}

#----------------------------------------------------------------------------------------------
# function to get feasible display modes (resolution + refresh rate) of a given display.
#
#
# args:
#   1: display name
#----------------------------------------------------------------------------------------------
function list_modes() {
    display=$1
    xrandr | awk -v monitor="^$display connected" '/connected/ {p = 0} $0 ~ monitor {p = 1} p' | grep -v ${display}
}

#----------------------------------------------------------------------------------------------
# function to get the highest refresh rate for a given display with a specific resolution.
#
#
# args:
#   1: display name
#   2: resolution
#----------------------------------------------------------------------------------------------
function get_highest_refresh_rate() {
    display=$1
    resolution=$2
    list_modes $display | grep $resolution | grep -o '[0-9][0-9]\.[0-9][0-9]' | sort -n -r | head -n 1
}

#----------------------------------------------------------------------------------------------
# function to get the highest resolution of a display.
#
#
# args:
#   1: display name
#----------------------------------------------------------------------------------------------
function get_highest_resolution() {
    list_modes ${1} | sort -n -r | head -n 1 | awk '{print $1}'
}

#----------------------------------------------------------------------------------------------
# function to compose xrandr option for turning on a display.
#
#
# args:
#   1: display name
#   2: resolution x
#   3: resolution y
#   4: refresh rate 
#   4: position x
#   5: position y
#   6: "primary" for set it as the primary display (optional)
#----------------------------------------------------------------------------------------------
function xrandr_opt_display_on() {
    opt="--output ${1} --mode ${2}x${3} --rate ${4} --pos ${5}x${6} --rotate normal"
    if [ $# -eq 6 ] && [ "${6}" == "primary" ]; then
        echo "${opt} --primary"
    else
	echo "${opt}"
    fi
}

#----------------------------------------------------------------------------------------------
# function to compose xrandr option for turning off a display. 
#
# args:
#   1: display name
#----------------------------------------------------------------------------------------------
function xrandr_opt_display_off() {
    echo "--output ${1} --off"
}

#----------------------------------------------------------------------------------------------
# function to set the primary display and turn others off.
#
#
# args:
#   1: primary display name
#   2: preferred mode in resolution:rate (e.g. 1024x768:60.00)
#----------------------------------------------------------------------------------------------
function set_primary_only() {
    pd_name=$1
    pd_mode=$( echo $2 | awk -F ':' '{print $1}' )
    pd_rate=$( echo $2 | awk -F ':' '{print $2}' )

    pd_res_x=$(echo $pd_mode | awk -F 'x' '{print $1}')
    pd_res_y=$(echo $pd_mode | awk -F 'x' '{print $2}')

    # do nothing if the primary display is not connected (i.e. $pd_name is empty)
    if [ "$pd_name" == "" ]; then
        return 0
    fi

    xrandr_opt=""
    for d in $( connected_external_displays ); do
        xrandr_opt="${xrandr_opt} $(xrandr_opt_display_off ${d})"
    done

    xrandr_opt="${xrandr_opt} $(xrandr_opt_display_on $pd_name $pd_res_x $pd_res_y $pd_rate 0 0 primary)"

    # run xrandr command
    xrandr $xrandr_opt
}

#----------------------------------------------------------------------------------------------
# function to set the external display on the top of the primary display.
#
#
# args:
#   1: external display name
#   2: preferred mode in resolution:rate (e.g. 1024x768:60.00)
#   3: position (top, left, right, mirror)
#----------------------------------------------------------------------------------------------
function set_external() {
    xd_name=$1
    xd_mode=$( echo $2 | awk -F ':' '{print $1}' )
    xd_rate=$( echo $2 | awk -F ':' '{print $2}' )
    xd_res_x=$(echo $xd_mode | awk -F 'x' '{print $1}')
    xd_res_y=$(echo $xd_mode | awk -F 'x' '{print $2}')

    pd_name=$(primary_display)
    pd_mode=$(get_highest_resolution $pd_name)
    pd_res_x=$(echo $pd_mode | awk -F 'x' '{print $1}')
    pd_res_y=$(echo $pd_mode | awk -F 'x' '{print $2}')
    pd_rate=$(get_highest_refresh_rate $pd_name $pd_mode)

    case $3 in
        left)
            xrandr_opt="$(xrandr_opt_display_on ${xd_name} ${xd_res_x} ${xd_res_y} ${xd_rate} 0 0)"
            xrandr_opt="${xrandr_opt} $(xrandr_opt_display_on ${pd_name} ${pd_res_x} ${pd_res_y} ${pd_rate} ${xd_res_x} 0 primary)"
	    ;;
        right)
            xrandr_opt="$(xrandr_opt_display_on ${xd_name} ${xd_res_x} ${xd_res_y} ${xd_rate} ${pd_res_x} 0)"
            xrandr_opt="${xrandr_opt} $(xrandr_opt_display_on ${pd_name} ${pd_res_x} ${pd_res_y} ${pd_rate} 0 0 primary)"
	    ;;
        mirror)
            # calculate scaling factor (optmized for the primary display)
            sx=$(echo "${pd_res_x}/${xd_res_x}" | bc -l)
            sy=$(echo "${pd_res_y}/${xd_res_y}" | bc -l)

	    xrandr_opt="$(xrandr_opt_display_on ${xd_name} ${xd_res_x} ${xd_res_y} ${xd_rate} 0 0) --same-as ${pd_name} --scale ${sx}x${sy}"
            xrandr_opt="${xrandr_opt} $(xrandr_opt_display_on ${pd_name} ${pd_res_x} ${pd_res_y} ${pd_rate} 0 0 primary)"
            ;;
        top | * )
            xrandr_opt="$(xrandr_opt_display_on ${xd_name} ${xd_res_x} ${xd_res_y} ${xd_rate} 0 0)"
            xrandr_opt="${xrandr_opt} $(xrandr_opt_display_on ${pd_name} ${pd_res_x} ${pd_res_y} ${pd_rate} 0 ${xd_res_y} primary)"
	    ;;
    esac

    # run xrandr command
    xrandr ${xrandr_opt}
}

#--------------------------
# main program start here!!
#--------------------------
display=$(primary_display)
resolution=$(get_highest_resolution $display)
rate=$(get_highest_refresh_rate $display $resolution)
mode="${resolution}:${rate}"
set_primary_only "$display" "$mode"
