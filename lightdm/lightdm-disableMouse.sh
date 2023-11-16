#!/bin/bash
####################################################################################################
# lightdm-disableMouse.sh
# by (github.com/t-truong)
# This script disables the mouse
#
# The script is called by LightDM when starting the greeter which disables
# the mouse on the login screen. When paired with lightdm-enableMouse.sh to be called when starting
# a session, it will disable mouse for lock screen but enable mouse for user.
####################################################################################################
Mouse_name="Corsair CORSAIR HARPOON RGB PRO Gaming Mouse" #exact string from "xinput --list"
                                                          #used to enable/disable mouse movement on turning off screen
id=$(xinput --list | grep "$Mouse_name" | grep -Po "(?<=id\=)\d*")
xinput --disable "$id"
