#!/bin/bash
####################################################################################################
# lightdm-enableMouse.sh
# by (https://github.com/t-truong)
# This script enables the mouse
#
# The script is called by LightDM when starting a session which enables
# the mouse for the user. When paired with lightdm-disableMouse.sh to be called when starting
# the greeter, it will disable mouse for lock screen but enable mouse for user.
####################################################################################################
Mouse_name="Corsair CORSAIR HARPOON RGB PRO Gaming Mouse" #exact string from "xinput --list"
                                                           #used to enable/disable mouse movement on turning off screen
id=$(xinput --list | grep "$Mouse_name" | grep -Po "(?<=id\=)\d*")
xinput --enable "$id"
