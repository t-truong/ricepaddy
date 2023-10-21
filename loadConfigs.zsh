#!/bin/zsh
####################################################################################################
# loadConfigs.zsh
# by t-truong
# This script harvests rice from the paddy
#
# zsh script that copies configuration files in this unitary source to their rightful place
# so that they are sourced/loaded appropriately.
#
# When editting configuration files, edit files from this unitary source and then load instead of
# editting the "live" version. This makes it much easier to keep track of/reuse/distribute
# all user configurations to different Linux systems.
####################################################################################################





autoload colors && colors
#Initialization-------------------------------------------------------------------------------------
Path_ScriptDirectory=${0:a:h} #absolute path of this script's directory
Path_ConfigDirectory="$HOME/.config"
mkdir -p "$Path_ConfigDirectory"
#00_Images------------------------------------------------------------------------------------------
OriginPath_image1="$Path_ScriptDirectory/00_Images/AmegakureOverlook.png"
OriginPath_image2="$Path_ScriptDirectory/00_Images/ArchLinuxLogo.png"
DestinationPath_images="/usr/share/pixmaps"

echo "Loading wallpapers/icons/images"
mkdir -p "$DestinationPath_images"

cp "$OriginPath_image1" "$DestinationPath_images"
cp "$OriginPath_image2" "$DestinationPath_images"
#X--------------------------------------------------------------------------------------------------
OriginPath_xinitrc="$Path_ScriptDirectory/X/xinitrc"
OriginPath_xprofile="$Path_ScriptDirectory/X/xprofile"
OriginPath_xserverrc="$Path_ScriptDirectory/X/xserverrc"
DestinationPath_xinitrc="$HOME/.xinitrc"
DestinationPath_xprofile="$HOME/.xprofile"
DestinationPath_xserverrc="$HOME/.xserverrc"

echo "Loading { $fg[cyan]xinit$reset_color } configuration..."

cp "$OriginPath_xinitrc" "$DestinationPath_xinitrc"
cp "$OriginPath_xprofile" "$DestinationPath_xprofile"
cp "$OriginPath_xserverrc" "$DestinationPath_xserverrc"
#bash-----------------------------------------------------------------------------------------------
OriginPath_bashrc="$Path_ScriptDirectory/bash/bashrc"
OriginPath_bashprofile="$Path_ScriptDirectory/bash/bash_profile"
OriginPath_inputrc="$Path_ScriptDirectory/bash/inputrc"
DestinationPath_bashrc="$HOME/.bashrc"
DestinationPath_bashprofile="$HOME/.bash_profile"
DestinationPath_inputrc="$HOME/.inputrc"

echo "Loading { $fg[cyan]bash$reset_color } configuration..."

cp "$OriginPath_bashrc" "$DestinationPath_bashrc"
cp "$OriginPath_bashprofile" "$DestinationPath_bashprofile"
cp "$OriginPath_inputrc" "$DestinationPath_inputrc"
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

cp "$OriginPath_vimrc" "$DestinationPath_vimrc"
rsync -a "$OriginPath_dracula" "$DestinationPath_dracula" \
    --exclude ".git" --exclude ".github" --exclude ".gitignore" --exclude "INSTALL.md"
#zsh------------------------------------------------------------------------------------------------
OriginPath_zprofile="$Path_ScriptDirectory/zsh/zprofile"
OriginPath_zshrc="$Path_ScriptDirectory/zsh/zshrc"
DestinationPath_zprofile="$HOME/.zprofile"
DestinationPath_zshrc="$HOME/.zshrc"

echo "Loading { $fg[cyan]zsh$reset_color } configuration..."
#replace ricepaddy variable in zshrc to proper path
#cannot get ricepaddy location from zshrc location because that changes
#cannot hard set ricepaddy location because that also changes
#must set the path from here
sed -i -E "s|local Path_ricepaddy=.*|local Path_ricepaddy=${Path_ScriptDirectory}|" "$OriginPath_zshrc"

cp "$OriginPath_zprofile" "$DestinationPath_zprofile"
cp "$OriginPath_zshrc" "$DestinationPath_zshrc"
#Exit-----------------------------------------------------------------------------------------------
if [[ "$SHELL" == "/bin/bash" ]]; then
    echo "Current shell is { $fg[cyan]$SHELL$reset_color }, sourcing bash configurations..."
    source "$DestinationPath_bashrc"
elif [[ "$SHELL" == "/bin/zsh" ]]; then
    echo "Current shell is { $fg[cyan]$SHELL$reset_color }, sourcing zsh configurations..."
    source "$DestinationPath_zshrc"
fi





####################################################################################################
# loadConfigs.sh
# by t-truong
# This script harvests rice from the paddy
####################################################################################################
