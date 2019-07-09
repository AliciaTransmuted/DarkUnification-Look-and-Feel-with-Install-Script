#!/bin/bash

#-------------------------------
# install.sh
# version 1.0.1
# Install DarkUnification KDE Plasma 5 Look and Feel Theme
# July 8, 2019
# AliciaTransmuted
# https://github.com/AliciaTransmuted/DarkUnification-Look-and-Feel-with-Install-Script
# -------------------------------
# dependancies: sed tar


###
### Functions
###

backup_file () {
if [ -e $1 ]; then
   backup_files=$(( backup_files + 1 ))
   make_dir $2
   /bin/cp -fv $1 $2 | tee -a "${installation_log}"
fi
return 0
} 

make_dir () {
if [ ! -d $1 ]; then
   mkdir -pv $1  | tee -a "${installation_log}"
fi
return 0
} 

add_to_log () {
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

temp_in_file="/home/""${username}""/.face.icon"
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

temp_dir="/home/""${username}""/Pictures/face"
make_dir "${temp_dir}"

temp_dir="/home/""${username}""/.local/share/color-schemes"
make_dir "${temp_dir}"

temp_dir="/home/""${username}""/.local/share/icons"
make_dir "${temp_dir}"

temp_dir="/home/""${username}""/.local/share/plasma"
make_dir "${temp_dir}"

/bin/cp -rf "${install_dir}"/face/face ~/.face
/bin/cp -rf "${install_dir}"/face/face ~/.face.icon

/bin/cp -rf "${install_dir}"/wallpaper/* ~/Pictures/DarkUnification

/bin/cp -rf "${install_dir}"/face/* ~/Pictures/face

/bin/cp -rf ~/Pictures/face/face0000/face0000.png ~/Pictures/face/face0000/.face
/bin/cp -rf ~/Pictures/face/face0000/face0000.png ~/Pictures/face/face0000/.face.icon
/bin/cp -rf ~/Pictures/face/face0001/face0001.png ~/Pictures/face/face0001/.face
/bin/cp -rf ~/Pictures/face/face0001/face0001.png ~/Pictures/face/face0001/.face.icon
/bin/cp -rf ~/Pictures/face/face0100/face0100.png ~/Pictures/face/face0100/.face
/bin/cp -rf ~/Pictures/face/face0100/face0100.png ~/Pictures/face/face0100/.face.icon
/bin/cp -rf ~/Pictures/face/face0101/face0101.png ~/Pictures/face/face0101/.face
/bin/cp -rf ~/Pictures/face/face0101/face0101.png ~/Pictures/face/face0101/.face.icon
/bin/cp -rf ~/Pictures/face/face0200/face0200.png ~/Pictures/face/face0200/.face
/bin/cp -rf ~/Pictures/face/face0200/face0200.png ~/Pictures/face/face0200/.face.icon
/bin/cp -rf ~/Pictures/face/face0201/face0201.png ~/Pictures/face/face0201/.face
/bin/cp -rf ~/Pictures/face/face0201/face0201.png ~/Pictures/face/face0201/.face.icon
/bin/cp -rf ~/Pictures/face/face0300/face0300.png ~/Pictures/face/face0300/.face
/bin/cp -rf ~/Pictures/face/face0300/face0300.png ~/Pictures/face/face0300/.face.icon
/bin/cp -rf ~/Pictures/face/face0301/face0301.png ~/Pictures/face/face0301/.face
/bin/cp -rf ~/Pictures/face/face0301/face0301.png ~/Pictures/face/face0301/.face.icon

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

log_entry="${log_heading_2}"
add_to_log

log_entry="${log_heading_4}"
add_to_log

log_entry="${log_heading_1}"
add_to_log
