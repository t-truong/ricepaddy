#!/bin/zsh
####################################################################################################
# installPackages.zsh
# by (github.com/t-truong)
# This script downloads rice cookers
#
# zsh script that installs packages that "rices" the Linux system.
# This script requires {zsh, make}.
# vim package is not specified because usually it comes with any Linux distro already.
####################################################################################################





if [ "$EUID" -ne 0 ]; then echo "This script needs to be executed as root"; exit; fi
autoload colors && colors
#Initialization-------------------------------------------------------------------------------------
PackageManager="pacman"
RefreshFlags="-Syy"           #Refresh repository
QueryPackageGroupFlags="-Qg" #Query installed package group
QueryPackageFlags="-Q"        #Query installed package
InstallFlags="-S"             #Install new package/groups

Path_ScriptDirectory=${0:a:h} #absolute path of this script's directory
PackageGroups=("xorg")
Packages=("ttf-space-mono-nerd" "picom" "tmux" "feh" "xdotool" "lightdm" "lightdm-gtk-greeter" #RICE
          "openssh"                                                                            #cryptography
          "python" "python-pip" "python-sphinx"                                                #python
          "noto-fonts-emoji")                                                                  #miscellaneous
StandalonePackages=("/suckless/dwm" "/suckless/slstatus" "/suckless/st")
$PackageManager $RefreshFlags
#Evaluate Package Groups----------------------------------------------------------------------------
#remove from install list if already in query
OriginalPackageGroups=("${PackageGroups[@]}")
for group in $PackageGroups; do
    query=$($PackageManager $QueryPackageGroupFlags $group 2> /dev/null)
    if [[ "$query" != "" ]]; then
        index_to_remove=${PackageGroups[(Ie)$group]}
        PackageGroups[index_to_remove]=()
    fi
done
if [ ${#PackageGroups} -eq 0 ]; then
    echo "Specified package groups {$fg[cyan]$(for value in $OriginalPackageGroups; do echo -n " $value "; done)$reset_color} already installed, skipping..."
else
    echo "Package groups to be installed are {$fg[cyan]$(for value in $PackageGroups; do echo -n " $value "; done)$reset_color}"
fi
#Evaluate Packages----------------------------------------------------------------------------------
#remove from install list if already in query
OriginalPackages=("${Packages[@]}")
for package in $Packages; do
    query=$($PackageManager $QueryPackageFlags $package 2> /dev/null)
    if [[ "$query" != "" ]]; then
        index_to_remove=${Packages[(Ie)$package]}
        Packages[index_to_remove]=()
    fi
done
if [ ${#Packages} -eq 0 ]; then
    echo "Specified packages {$fg[cyan]$(for value in $OriginalPackages; do echo -n " $value "; done)$reset_color} already installed, skipping..."
else
    echo "Packages to be installed are {$fg[cyan]$(for value in $Packages; do echo -n " $value "; done)$reset_color}"
fi
#Evaluate Standalone Packages-----------------------------------------------------------------------
OriginalStandalonePackages=("${StandalonePackages[@]}")
for package in $StandalonePackages; do
    query=$(type $(basename $package))
    if [[ "$query" != "$(basename $package) not found" ]]; then
        index_to_remove=${StandalonePackages[(Ie)$package]}
        StandalonePackages[index_to_remove]=()
    fi
done
if [ ${#StandalonePackages} -eq 0 ]; then
    echo "Specified standalone packages {$fg[cyan]$(for value in $OriginalStandalonePackages; do echo -n " $value "; done)$reset_color} already installed, skipping..."
else
    echo "Standalone packages to be installed are {$fg[cyan]$(for value in $StandalonePackages; do echo -n " $value "; done)$reset_color}"
fi
#Install--------------------------------------------------------------------------------------------
read -q "confirm?Continue to install? [y/N]: " && [[ "$confirm" == [yY] ]] || exit 0
if [[ ${#PackageGroups} -gt 0 || ${#Packages} -gt 0 ]]; then
    $PackageManager $InstallFlags $PackageGroups $Packages
fi
if [[ ${#StandalonePackages} -gt 0 ]]; then
    for package in $StandalonePackages; do
        make -C $Path_ScriptDirectory$package clean install
    done
fi





####################################################################################################
# installPackages.zsh
# by (github.com/t-truong)
# This script downloads rice cookers
####################################################################################################
