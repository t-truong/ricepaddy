#!/bin/zsh
####################################################################################################
# loadConfigs.zsh
# by (github.com/t-truong)
# This script harvests rice from the paddy
#
# zsh script that copies configuration files in this unitary source to their rightful place
# so that they are sourced/loaded appropriately.
#
# When editting configuration files, edit files from this unitary source and then load instead of
# editting the "live" version. This makes it much easier to keep track of/reuse/distribute
# all user configurations to different Linux systems.
####################################################################################################





if [ "$EUID" -ne 0 ]; then echo "This script needs to be executed as superuser"; exit; fi
USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
autoload colors && colors
#Initialization-------------------------------------------------------------------------------------
Path_ScriptDirectory=${0:a:h} #absolute path of this script's directory
Path_ConfigDirectory="$USER_HOME/.config"
mkdir -p "$Path_ConfigDirectory"
#00_Images------------------------------------------------------------------------------------------
OriginPath_image1="$Path_ScriptDirectory/99_Images/AmegakureOverlook.png"
OriginPath_image2="$Path_ScriptDirectory/99_Images/ArchLinuxLogo.png"
DestinationPath_images="/usr/share/pixmaps"

echo "Loading wallpapers/icons/images"
mkdir -p "$DestinationPath_images"

cp "$OriginPath_image1" "$DestinationPath_images"
cp "$OriginPath_image2" "$DestinationPath_images"
chown root "$DestinationPath_images/$OriginPath_image1:t" "$DestinationPath_images/$OriginPath_image2:t"
chgrp root "$DestinationPath_images/$OriginPath_image1:t" "$DestinationPath_images/$OriginPath_image2:t"
chmod 644 "$DestinationPath_images/$OriginPath_image1:t" "$DestinationPath_images/$OriginPath_image2:t"
#X--------------------------------------------------------------------------------------------------
OriginPath_xinitrc="$Path_ScriptDirectory/X/xinitrc"
OriginPath_xprofile="$Path_ScriptDirectory/X/xprofile"
OriginPath_xserverrc="$Path_ScriptDirectory/X/xserverrc"
DestinationPath_xinitrc="$USER_HOME/.xinitrc"
DestinationPath_xprofile="$USER_HOME/.xprofile"
DestinationPath_xserverrc="$USER_HOME/.xserverrc"

echo "Loading { $fg[cyan]xinit$reset_color } configuration..."

cp "$OriginPath_xinitrc" "$DestinationPath_xinitrc"
cp "$OriginPath_xprofile" "$DestinationPath_xprofile"
cp "$OriginPath_xserverrc" "$DestinationPath_xserverrc"
#bash-----------------------------------------------------------------------------------------------
OriginPath_bashrc="$Path_ScriptDirectory/bash/bashrc"
OriginPath_bashprofile="$Path_ScriptDirectory/bash/bash_profile"
OriginPath_inputrc="$Path_ScriptDirectory/bash/inputrc"
DestinationPath_bashrc="$USER_HOME/.bashrc"
DestinationPath_bashprofile="$USER_HOME/.bash_profile"
DestinationPath_inputrc="$USER_HOME/.inputrc"

echo "Loading { $fg[cyan]bash$reset_color } configuration..."

cp "$OriginPath_bashrc" "$DestinationPath_bashrc"
cp "$OriginPath_bashprofile" "$DestinationPath_bashprofile"
cp "$OriginPath_inputrc" "$DestinationPath_inputrc"
#lightdm--------------------------------------------------------------------------------------------
OriginPath_lightdmconf="$Path_ScriptDirectory/lightdm/lightdm.conf"
OriginPath_lightdmgreeterconf="$Path_ScriptDirectory/lightdm/lightdm-gtk-greeter.conf"
OriginPath_lightdm_enableMouse="$Path_ScriptDirectory/lightdm/lightdm-enableMouse.sh"
OriginPath_lightdm_disableMouse="$Path_ScriptDirectory/lightdm/lightdm-disableMouse.sh"
DestinationPath_lightdm="/etc/lightdm"
DestinationPath_scripts="/usr/share"

if [[ ! -d "$DestinationPath_lightdm" ]]; then
    echo "$fg[red]Error:$reset_color Directory { $fg[cyan]$DestinationPath_lightdm$reset_color } not found"
    echo "$fg[red]Error:$reset_color { $fg[cyan]lightdm$reset_color } package likely not installed"
    exit 1
fi
echo "Loading { $fg[cyan]lightdm$reset_color } configuration..."
mkdir -p "$DestinationPath_scripts"

cp "$OriginPath_lightdmconf" "$DestinationPath_lightdm"
cp "$OriginPath_lightdmgreeterconf" "$DestinationPath_lightdm"
cp "$OriginPath_lightdm_enableMouse" "$DestinationPath_scripts"
cp "$OriginPath_lightdm_disableMouse" "$DestinationPath_scripts"
chown root "$DestinationPath_scripts/$OriginPath_lightdm_enableMouse:t" "$DestinationPath_scripts/$OriginPath_lightdm_disableMouse:t"
chgrp root "$DestinationPath_scripts/$OriginPath_lightdm_enableMouse:t" "$DestinationPath_scripts/$OriginPath_lightdm_disableMouse:t"
chmod 755 "$DestinationPath_scripts/$OriginPath_lightdm_enableMouse:t" "$DestinationPath_scripts/$OriginPath_lightdm_disableMouse:t"
#git------------------------------------------------------------------------------------------------
echo -n "Nothing to load for { $fg[cyan]git$reset_color }. \$GIT_CONFIG_GLOBAL environment variable set in \"zshrc\" tells "
echo    "git to read/write configurations directly to ricepaddy"
#picom----------------------------------------------------------------------------------------------
OriginPath_picomconf="$Path_ScriptDirectory/picom/picom.conf"
DestinationPath_picomconf="$Path_ConfigDirectory/picom"

echo "Loading { $fg[cyan]picom$reset_color } configuration..."
mkdir -p "$Path_ConfigDirectory/picom"

cp "$OriginPath_picomconf" "$DestinationPath_picomconf"
#tmux-----------------------------------------------------------------------------------------------
OriginPath_tmuxconfig="$Path_ScriptDirectory/tmux/tmux.config"
DestinationPath_tmuxconfig="$Path_ConfigDirectory/tmux"

echo "Loading { $fg[cyan]tmux$reset_color } configuration..."
mkdir -p "$Path_ConfigDirectory/tmux"

cp "$OriginPath_tmuxconfig" "$DestinationPath_tmuxconfig"
#vim------------------------------------------------------------------------------------------------
OriginPath_vimrc="$Path_ScriptDirectory/vim/vimrc"
OriginPath_dracula="$Path_ScriptDirectory/vim/dracula"
DestinationPath_vimrc="$Path_ConfigDirectory/vim"
DestinationPath_dracula="$Path_ConfigDirectory/vim/pack/themes/start"

echo "Loading { $fg[cyan]vim$reset_color } configuration..."
mkdir -p "$Path_ConfigDirectory/vim/pack/bundle/start" "$Path_ConfigDirectory/vim/pack/themes/start"
#replace ricepaddy template path in vimrc to proper path
#cannot hard set this as git repo can be in abitrary path
#must set path from here
sed -i -E "s|let b:Path_templates=.*|let b:Path_templates= '${Path_ScriptDirectory}/00_Templates'|" "$OriginPath_vimrc"

cp "$OriginPath_vimrc" "$DestinationPath_vimrc"
rsync -a "$OriginPath_dracula" "$DestinationPath_dracula" \
    --exclude ".git" --exclude ".github" --exclude ".gitignore" --exclude "INSTALL.md"
#zsh------------------------------------------------------------------------------------------------
OriginPath_zprofile="$Path_ScriptDirectory/zsh/zprofile"
OriginPath_zshrc="$Path_ScriptDirectory/zsh/zshrc"
DestinationPath_zprofile="$USER_HOME/.zprofile"
DestinationPath_zshrc="$USER_HOME/.zshrc"

echo "Loading { $fg[cyan]zsh$reset_color } configuration..."
#replace ricepaddy variable in zshrc to proper path
#cannot get ricepaddy location from zshrc location because that changes
#cannot hard set ricepaddy location because that also changes
#must set the path from here
sed -i -E "s|local Path_ricepaddy=.*|local Path_ricepaddy=${Path_ScriptDirectory}|" "$OriginPath_zshrc"

cp "$OriginPath_zprofile" "$DestinationPath_zprofile"
cp "$OriginPath_zshrc" "$DestinationPath_zshrc"
#Exit-----------------------------------------------------------------------------------------------
echo "Configurations loaded and ready to be sourced"





####################################################################################################
# loadConfigs.sh
# by (github.com/t-truong)
# This script harvests rice from the paddy
####################################################################################################
