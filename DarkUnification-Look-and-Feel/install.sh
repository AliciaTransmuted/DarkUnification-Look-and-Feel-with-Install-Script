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
   temp_dir="${backup_dir}""/.config/gtk-3.0"
   if [ ! -d "${temp_dir}" ]; then
      mkdir -pv "${temp_dir}"
   fi
   cp -v ~/.config/gtk-3.0/settings.ini "${temp_dir}"
fi

if [ -e ~/.config/breezerc ]; then
   backup_files=$(( backup_files + 1 ))
   temp_dir="${backup_dir}""/.config"
   if [ ! -d "${temp_dir}" ]; then
      mkdir -pv "${temp_dir}"
   fi
   cp -v ~/.config/breezerc "${temp_dir}"
fi

if [ -e ~/.config/dolphinrc ]; then
   backup_files=$(( backup_files + 1 ))
   temp_dir="${backup_dir}""/.config"
   if [ ! -d "${temp_dir}" ]; then
      mkdir -pv "${temp_dir}"
   fi
   cp -v ~/.config/dolphinrc "${temp_dir}"
fi

if [ -e ~/.config/gtkrc ]; then
   backup_files=$(( backup_files + 1 ))
   temp_dir="${backup_dir}""/.config"
   if [ ! -d "${temp_dir}" ]; then
      mkdir -pv "${temp_dir}"
   fi
   cp -v ~/.config/gtkrc "${temp_dir}"
fi

if [ -e ~/.config/gtkrc-2.0 ]; then
   backup_files=$(( backup_files + 1 ))
   temp_dir="${backup_dir}""/.config"
   if [ ! -d "${temp_dir}" ]; then
      mkdir -pv "${temp_dir}"
   fi
   cp -v ~/.config/gtkrc-2.0 "${temp_dir}"
fi

if [ -e ~/.config/kwinrc ]; then
   backup_files=$(( backup_files + 1 ))
   temp_dir="${backup_dir}""/.config"
   if [ ! -d "${temp_dir}" ]; then
      mkdir -pv "${temp_dir}"
   fi
   cp -v ~/.config/kwinrc "${temp_dir}"
fi

if [ -e ~/.config/plasma-org.kde.plasma.desktop-appletsrc ]; then
   backup_files=$(( backup_files + 1 ))
   temp_dir="${backup_dir}""/.config"
   if [ ! -d "${temp_dir}" ]; then
      mkdir -pv "${temp_dir}"
   fi
   cp -v ~/.config/plasma-org.kde.plasma.desktop-appletsrc "${temp_dir}"
fi

echo "${backup_files}"" file(s) backed up to ""${backup_dir}"

### 
### Copy all data from DarkUnification Folder to new directories
### 
### Install the DarkUnification Theme
### 

cp -r ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/color-schemes ~/.local/share/
cp -r ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/plasma ~/.local/share/

sed -i -e s/xxUSERNAMExx/"${user_name}"/g ~/.local/share/plasma/look-and-feel/DarkUnification/contents/layouts/org.kde.plasma.desktop-layout.js

cd ~/.local/share/plasma/look-and-feel
tar -czvf ~/DarkUnification.tar.gz DarkUnification/*
cd

kpackagetool5 -r ~/DarkUnification.tar.gz
kpackagetool5 -i ~/DarkUnification.tar.gz

cp -r ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/icons ~/.local/share/

### 
### Configure the DarkUnification Theme
### 

# Popup Message
kdialog --title "Please Select
DarkUnification Look and Feel Theme!
Check Use Desktop Layout from Theme" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification theme
kcmshell5 kcm_lookandfeel

# Popup Message
kdialog --title "Please Select 
the prefered Splashscreen!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Splashscreen
kcmshell5 kcm_splashscreen

# Setup Color schemes
kdialog --title "Please Select
DarkUnification Color Scheme!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification Color Scheme
kcmshell5 colors

# Popup Message
#kdialog --title "Click Adjust All Fonts
#Please Select 
#Ubuntu Fonts
#for a complete Unity experience!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Fonts
#kcmshell5 fonts

# Popup Message
kdialog --title "Global Menu activation!
PLEASE CLICK ON FINE TUNING TAB!
CLICK ON MENUBAR STYLE
SELECT APPLICATION MENU WIDGET!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Global menu
kcmshell5 style

# Setup window decoration
kdialog --title "Please Select
DarkUnification ????!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification window decoration
kcmshell5 kwindecoration

# Popup Message
kdialog --title "Please Select 
DarkUnification for GTK 2/3 Theme!
Please Select 
Icon Theme Ultimate Edition Dark Glass!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# GTK Theme setup
kcmshell5 kde-gtk-config

# Popup Message
kdialog --title "Please Select 
Humanity Icon Theme!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Icon Theme setup
kcmshell5 icons

### 
### Copy config files after theme setup
### 

cp -r ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/.config ~/
cp -r ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/.themes ~/
