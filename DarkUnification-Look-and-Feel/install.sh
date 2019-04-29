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

cd

user_name=$USER
echo "Install DarkUnification KDE Plasma 5 Theme for ""${user_name}"

backup_dir="/home/""${user_name}""/.local/share/plasma/look-and-feel/DarkUnification/backups/""${user_name}""/""$(date '+%Y-%m-%d-%H-%M-%S')"
echo "Backup Directory: ""${backup_dir}"

backup_files=0

### 
### Backup all config files this script will overwrite to a user named, date and time stamped directory
### 

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
### Copy all data from DarkUnification Folder to new directories
### 
### Install the DarkUnification Theme
### 

/bin/cp -rf ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/color-schemes ~/.local/share/
/bin/cp -rf ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/plasma ~/.local/share/
/bin/cp -rf ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/icons ~/.local/share/
/bin/cp -rf ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/config/* ~/.config
/bin/cp -rf ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/themes/* ~/.themes
/bin/cp -rf ~//home/systst/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/plasma/look-and-feel/DarkUnification/contents/wallpaper/face ~

sed -i -e s/xxUSERNAMExx/"${user_name}"/g ~/.local/share/plasma/look-and-feel/DarkUnification/contents/layouts/org.kde.plasma.desktop-layout.js

cd ~/.local/share/plasma/look-and-feel
tar -czvf ~/DarkUnification.tar.gz DarkUnification/*
cd

kpackagetool5 -r ~/DarkUnification.tar.gz
kpackagetool5 -i ~/DarkUnification.tar.gz

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
#kdialog --title "Please Select 
#the prefered Splashscreen!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Splashscreen
#kcmshell5 kcm_splashscreen

# Setup Color schemes
#kdialog --title "Please Select
#DarkUnification Color Scheme!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification Color Scheme
#kcmshell5 colors

# Popup Message
#kdialog --title "Click Adjust All Fonts
#Please Select 
#Ubuntu Fonts
#for a complete Unity experience!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Fonts
#kcmshell5 fonts

# Popup Message
#kdialog --title "Global Menu activation!
#PLEASE CLICK ON FINE TUNING TAB!
#CLICK ON MENUBAR STYLE
#SELECT APPLICATION MENU WIDGET!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup Global menu
#kcmshell5 style

# Setup window decoration
#kdialog --title "Please Select
#DarkUnification ????!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification window decoration
#kcmshell5 kwindecoration

# Popup Message
kdialog --title "Please Select 
DarkUnification for GTK 2/3 Theme!
Please Select 
Icon Theme Ultimate Edition Dark Glass!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# GTK Theme setup
kcmshell5 kde-gtk-config

# Popup Message
kdialog --title "Please Select 
Ultimate Edition Dark Glass Icon Theme!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Icon Theme setup
kcmshell5 icons

### 
### Copy config files after theme setup
### 

/bin/cp -rf ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/config/* ~/.config
/bin/cp -rf ~/DarkUnification-Look-and-Feel-master/DarkUnification-Look-and-Feel/themes/* ~/.themes
