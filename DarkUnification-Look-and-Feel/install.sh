#!/bin/bash

###
### Dependancies: sed
###

###
### Functions
###

backup_config () {
if [ -e $1 ]; then
   backup_files=$(( backup_files + 1 ))
   if [ ! -d $2 ]; then
      mkdir -pv $2
   fi
   /bin/cp -v $1 $2
fi
return 0
} 

###
### Setup variables
###

install_dir=$PWD

user_name=$USER
echo "Install DarkUnification KDE Plasma 5 Theme for ""${user_name}"

backup_dir="/home/""${user_name}""/.local/share/plasma/look-and-feel/DarkUnification/backups/""$(date '+%Y-%m-%d-%H-%M-%S')"
echo "Backup Directory: ""${backup_dir}"

backup_files=0

### 
### Backup all config files this script will overwrite to a user named, date and time stamped directory
### 

temp_in_file="/home/""${user_name}""/.face"
temp_out_dir="${backup_dir}"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/gtk-3.0/gtk.css"
temp_out_dir="${backup_dir}""/.config/gtk-3.0"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/gtk-3.0/settings.ini"
temp_out_dir="${backup_dir}""/.config/gtk-3.0"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/breezerc"
temp_out_dir="${backup_dir}""/.config"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/dolphinrc"
temp_out_dir="${backup_dir}""/.config"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/gtkrc"
temp_out_dir="${backup_dir}""/.config"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/gtkrc-2.0"
temp_out_dir="${backup_dir}""/.config"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/kwinrc"
temp_out_dir="${backup_dir}""/.config"
backup_config "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${user_name}""/.config/plasma-org.kde.plasma.desktop-appletsrc"
temp_out_dir="${backup_dir}""/.config"
backup_config "${temp_in_file}" "${temp_out_dir}"

echo "${backup_files}"" file(s) backed up to ""${backup_dir}"

### 
### Copy all data from DarkUnification Folders to new directories
### 

if [ ! -d ~/.config ]; then
   mkdir -p ~/.config
fi

if [ ! -d ~/.themes ]; then
   mkdir -p ~/.themes
fi

if [ ! -d ~/.local/share/icons ]; then
   mkdir -p ~/.local/share/icons
fi

/bin/cp -rf "${install_dir}"/color-schemes ~/.local/share/
/bin/cp -rf "${install_dir}"/plasma ~/.local/share/
/bin/cp -rf "${install_dir}"/icons/* ~/.local/share/icons
/bin/cp -rf "${install_dir}"/config/* ~/.config
/bin/cp -rf "${install_dir}"/themes/* ~/.themes
/bin/cp -rf "${install_dir}"/plasma/look-and-feel/DarkUnification/contents/wallpaper/face ~/.face

### 
### Install the DarkUnification Theme
### 

sed -i -e s/xxUSERNAMExx/"${user_name}"/g ~/.local/share/plasma/look-and-feel/DarkUnification/contents/layouts/org.kde.plasma.desktop-layout.js

cd ~/.local/share/plasma/look-and-feel
tar -czvf ~/DarkUnification.tar.gz DarkUnification/*
cd "${install_dir}"

/usr/bin/kpackagetool5 -r ~/DarkUnification.tar.gz
/usr/bin/kpackagetool5 -i ~/DarkUnification.tar.gz

### 
### Configure the DarkUnification Theme
### 

# Popup Message
/usr/bin/kdialog --title "Please Select
DarkUnification Look and Feel Theme!
Check Use Desktop Layout from Theme" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification theme
/usr/bin/kcmshell5 kcm_lookandfeel

# Popup Message
/usr/bin/kdialog --title "Please Select 
Ultimate Edition Dark Glass Icon Theme!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Icon Theme setup
/usr/bin/kcmshell5 icons

# Popup Message
/usr/bin/kdialog --title "Please Select 
DarkUnification for GTK 2/3 Theme!
Please Select 
Icon Theme Ultimate Edition Dark Glass!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# GTK Theme setup
/usr/bin/kcmshell5 kde-gtk-config

# Popup Message
#/usr/bin/kdialog --title "Please Select 
#the prefered Splashscreen!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Splashscreen
#/usr/bin/kcmshell5 kcm_splashscreen

# Setup Color schemes
#/usr/bin/kdialog --title "Please Select
#DarkUnification Color Scheme!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification Color Scheme
#/usr/bin/kcmshell5 colors

# Popup Message
#/usr/bin/kdialog --title "Click Adjust All Fonts
#Please Select 
#Ubuntu Fonts
#for a complete Unity experience!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Fonts
#/usr/bin/kcmshell5 fonts

# Popup Message
#/usr/bin/kdialog --title "Global Menu activation!
#PLEASE CLICK ON FINE TUNING TAB!
#CLICK ON MENUBAR STYLE
#SELECT APPLICATION MENU WIDGET!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Global menu
#/usr/bin/kcmshell5 style

# Setup window decoration
#/usr/bin/kdialog --title "Please Select
#DarkUnification ????!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification window decoration
#/usr/bin/kcmshell5 kwindecoration

### 
### Copy config files after theme setup
### 

/bin/cp -rf "${install_dir}"/config/* ~/.config
/bin/cp -rf "${install_dir}"/themes/* ~/.themes
