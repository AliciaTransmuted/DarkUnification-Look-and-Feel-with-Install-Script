#!/bin/bash

###
### Dependancies: sed
###

###
### Setup variables
###

user_name=$USER
echo "Install DarkUnification KDE Plasma 5 Theme for ""${user_name}"

backup_dir="~/.local/share/plasma/look-and-feel/DarkUnification/backups/"${user_name}"/"$(date '+%Y-%m-%d-%H-%M-%S')
echo "Backup Directory: ""${backup_dir}"

backup_files=0

### 
### Backup all config files this script will overwrite to a user named, date and time stamped directory
### 

if [ -e ~/.config/gtk-3.0/settings.ini ]; then
   backup_files=$(( backup_files + 1 ))
   mkdir -pv "${backup_dir}""/.config/gtk-3.0"
   cp -v ~/.config/gtk-3.0/settings.ini "${backup_dir}""/.config/gtk-3.0"
fi

if [ -e ~/.config/breezerc ]; then
   backup_files=$(( backup_files + 1 ))
   mkdir -pv "${backup_dir}""/.config"
   cp -v ~/.config/breezerc "${backup_dir}""/.config"
fi

if [ -e ~/.config/kwinrc ]; then
   backup_files=$(( backup_files + 1 ))
   mkdir -pv "${backup_dir}""/.config"
   cp -v ~/.config/kwinrc "${backup_dir}""/.config"
fi

if [ -e ~/.config/plasma-org.kde.plasma.desktop-appletsrc ]; then
   backup_files=$(( backup_files + 1 ))
   mkdir -pv "${backup_dir}""/.config"
   cp -v ~/.config/plasma-org.kde.plasma.desktop-appletsrc "${backup_dir}""/.config"
fi

echo "${backup_files}"" file(s) backed up to ""${backup_dir}"

### 
### Copy all data from DarkUnification Folder to new directories
### 
### Install the DarkUnification Theme
### 

cp -rv ~/DarkUnification-Look-and-Feel-master/config/* ~/.config
cp -rv ~/DarkUnification-Look-and-Feel-master/themes/* ~/.themes
cp -rv ~/DarkUnification-Look-and-Feel-master/color-schemes ~/.local/share/
cp -rv ~/DarkUnification-Look-and-Feel-master/icons ~/.local/share/
cp -rv ~/DarkUnification-Look-and-Feel-master/plasma ~/.local/share/

sed -i -e s/xxUSERNAMExx/"${user_name}"/g ~/.local/share/plasma/look-and-feel/DarkUnification/contents/layouts/org.kde.plasma.desktop-layout.js

tar -czvf ~/DarkUnification.tar.gz ~/.local/share/plasma/look-and-feel/DarkUnification

kpackagetool5 -i ~/DarkUnification.tar.gz

# copy config files after theme setup
cp -rv ~/DarkUnification-Look-and-Feel-master/.config ~/
cp -rv ~/DarkUnification-Look-and-Feel-master/.themes ~/
