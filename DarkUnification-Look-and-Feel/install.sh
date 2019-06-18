#!/bin/bash

#-------------------------------
# install.sh
# version 1.0
# Install DarkUnification KDE Plasma 5 Look and Feel Theme
# June 15, 2019
# AliciaTransmuted
# https://github.com/AliciaTransmuted/DarkUnification-Look-and-Feel-with-Install-Script
# -------------------------------
# dependancies: sed tar


###
### Functions
###

function backup_file () {
if [ -e $1 ]; then
   backup_files=$(( backup_files + 1 ))
   make_dir $2
   /bin/cp -fv $1 $2 | tee -a "${installation_log}"
fi
return 0
} 

function make_dir () {
if [ ! -d $1 ]; then
   mkdir -pv $1  | tee -a "${installation_log}"
fi
return 0
} 

function add_to_log () {
echo "${log_entry}" >> "${installation_log}"
printf '%s\n' "${log_entry}"
return 0
} 


###
### Setup variables
###

username=$USER

if [ -n "$SUDO_USER" ]; then
   username=$SUDO_USER
fi

shell_name="`basename "$0"`"
shell_dir="`dirname "$0"`"
working_dir=$PWD

if [ "${shell_dir}" = "." ]; then
   install_dir="${working_dir}"
else
   install_dir="${working_dir}""/""${shell_dir}"
fi

backup_dir="${install_dir}""/backups/""$(date '+%Y-%m-%d-%H-%M-%S')"
installation_log="${backup_dir}""/installation.log"
backup_files=0
log_heading_1="================================================================================================================="
log_heading_2="-------------------------------------------------------------------------------------------------------------"
log_heading_3="............................................................................................................."
log_heading_4="J O B     H A S     C O M P L E T E D"

make_dir "${backup_dir}"

log_entry="${log_heading_1}"
echo "${log_entry}" > "${installation_log}"
printf '%s\n' "${log_entry}"

log_entry="Install DarkUnification KDE Plasma 5 Theme for User: ""${username}"
add_to_log

log_entry="${log_heading_2}"
add_to_log

log_entry="Backup Directory: ""${backup_dir}"
add_to_log

log_entry="${log_heading_3}"
add_to_log

### 
### Backup all config files this script will overwrite to a user named, date and time stamped directory
### 

temp_in_file="/home/""${username}""/.face"
temp_out_dir="${backup_dir}"
backup_file "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${username}""/.config/gtk-3.0/settings.ini"
temp_out_dir="${backup_dir}""/.config/gtk-3.0"
backup_file "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${username}""/.config/dolphinrc"
temp_out_dir="${backup_dir}""/.config"
backup_file "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${username}""/.config/kscreenlockerrc"
temp_out_dir="${backup_dir}""/.config"
backup_file "${temp_in_file}" "${temp_out_dir}"

temp_in_file="/home/""${username}""/.gtkrc-2.0"
temp_out_dir="${backup_dir}"
backup_file "${temp_in_file}" "${temp_out_dir}"

log_entry="${log_heading_3}"
add_to_log

if [ "${backup_files}" -eq "1" ]; then
   log_entry="${backup_files}"" file backed up to ""${backup_dir}"
else
   log_entry="${backup_files}"" files backed up to ""${backup_dir}"
fi

add_to_log

log_entry="${log_heading_3}"
add_to_log

### 
### Copy all data from DarkUnification Folders to new directories
### 

temp_dir="/home/""${username}""/Pictures/DarkUnification"
make_dir "${temp_dir}"

temp_dir="/home/""${username}""/.local/share/color-schemes"
make_dir "${temp_dir}"

temp_dir="/home/""${username}""/.local/share/icons"
make_dir "${temp_dir}"

temp_dir="/home/""${username}""/.local/share/plasma"
make_dir "${temp_dir}"

/bin/cp -rf "${install_dir}"/plasma/look-and-feel/DarkUnification/contents/wallpaper/face ~/.face

/bin/cp -rf "${install_dir}"/plasma/look-and-feel/DarkUnification/contents/wallpaper/* ~/Pictures/DarkUnification

/bin/cp -rf "${install_dir}"/color-schemes/* ~/.local/share/color-schemes

/bin/cp -rf "${install_dir}"/icons/* ~/.local/share/icons

/bin/cp -rf "${install_dir}"/plasma/* ~/.local/share/plasma

### 
### Install the DarkUnification Theme
### 

sed -i -e s/xxUSERNAMExx/"${username}"/g ~/.local/share/plasma/look-and-feel/DarkUnification/contents/layouts/org.kde.plasma.desktop-layout.js

cd ~/.local/share/plasma/look-and-feel
tar -czvf ~/DarkUnification.tar.gz DarkUnification/* | tee -a "${installation_log}"
cd $PWD

/usr/bin/kpackagetool5 -r ~/DarkUnification.tar.gz > /dev/null 2>&1

log_entry="${log_heading_3}"
add_to_log

log_entry="This next process may take some time as several Plasma 5 objects must be installed"
add_to_log

log_entry="***** Please enter your sudo password when requested *****"
add_to_log

log_entry="Please be patient"
add_to_log

log_entry="${log_heading_3}"
add_to_log

/usr/bin/kpackagetool5 -i ~/DarkUnification.tar.gz | tee -a "${installation_log}"

### 
### Configure the DarkUnification Theme
### 

# Popup Message
/usr/bin/kdialog --title "Please Select
DarkUnification Look and Feel Theme!
Check Use Desktop Layout from Theme" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the DarkUnification theme
/usr/bin/kcmshell5 kcm_lookandfeel 2>/dev/null

log_entry="***** Please enter your sudo password when requested *****"
add_to_log

# Popup Message
/usr/bin/kdialog --title "Please Select
Chili for Plasma Login Screen (SDDM)!
Enter password when requested" --passivepopup "This popup will disappear in 15 seconds" 15 &
# Setup the Chili for Plasma Login Screen (SDDM)
/usr/bin/kcmshell5 kcm_sddm 2>/dev/null

temp_dir="/home/""${username}""/.config"
make_dir "${temp_dir}"

temp_dir="/home/""${username}""/.themes"
make_dir "${temp_dir}"

/bin/cp -rf "${install_dir}"/config/* ~/.config

/bin/cp -rf "${install_dir}"/config-other/gtkrc-2.0 ~/.gtkrc-2.0

/bin/cp -rf "${install_dir}"/themes/* ~/.themes

sed -i -e s/xxUSERNAMExx/"${username}"/g ~/.config/kscreenlockerrc

# Popup Message
/usr/bin/kdialog --title "Please Select 
DarkUnification for GTK 2/3 Theme!
Please Select 
Icon Theme Ultimate Edition Dark Glass!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# GTK Theme setup
/usr/bin/kcmshell5 kde-gtk-config 2>/dev/null

log_entry="${log_heading_2}"
add_to_log

log_entry="${log_heading_4}"
add_to_log

log_entry="${log_heading_1}"
add_to_log
