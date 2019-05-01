#!/bin/bash

###
### Dependancies: sed tar
###

###
### Functions
###

backup_config () {
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

install_dir=$PWD
user_name=$USER
backup_dir="${install_dir}""/backups/""$(date '+%Y-%m-%d-%H-%M-%S')"
installation_log="${backup_dir}""/installation.log"
templog="${backup_dir}""/temp.log"
backup_files=0
log_heading_1="================================================================================================================="
log_heading_2="-------------------------------------------------------------------------------------------------------------"
log_heading_3="............................................................................................................."
log_heading_4="J O B     H A S     C O M P L E T E D"

make_dir "${backup_dir}"

log_entry="${log_heading_1}"
echo "${log_entry}" > "${installation_log}"
printf '%s\n' "${log_entry}"

log_entry="Install DarkUnification KDE Plasma 5 Theme for User: ""${user_name}"
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

temp_in_file="/home/""${user_name}""/.config/plasmarc"
temp_out_dir="${backup_dir}""/.config"
backup_config "${temp_in_file}" "${temp_out_dir}"

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

echo "/home/""${user_name}""/.config" $(make_dir)
echo "/home/""${user_name}""/.local/share/icons" $(make_dir)
echo "/home/""${user_name}""/Pictures/DarkUnification" $(make_dir)

/bin/cp -rf "${install_dir}"/plasma/look-and-feel/DarkUnification/contents/wallpaper/face ~/.face
/bin/cp -rf "${install_dir}"/plasma/look-and-feel/DarkUnification/contents/wallpaper/Locked.jpg ~/Pictures/DarkUnification/Locked.jpg
/bin/cp -rf "${install_dir}"/plasma/look-and-feel/DarkUnification/contents/wallpaper/Wilted.jpg ~/Pictures/DarkUnification/Wilted.jpg

/bin/cp -rf "${install_dir}"/color-schemes ~/.local/share/
/bin/cp -rf "${install_dir}"/plasma ~/.local/share/
/bin/cp -rf "${install_dir}"/icons/* ~/.local/share/icons
/bin/cp -rf "${install_dir}"/config/* ~/.config
/bin/cp -rf "${install_dir}"/themes/* ~/.themes

### 
### Install the DarkUnification Theme
### 

sed -i -e s/xxUSERNAMExx/"${user_name}"/g ~/.config/plasmarc
sed -i -e s/xxUSERNAMExx/"${user_name}"/g ~/.local/share/plasma/look-and-feel/DarkUnification/contents/layouts/org.kde.plasma.desktop-layout.js

cd ~/.local/share/plasma/look-and-feel
tar -czvf ~/DarkUnification.tar.gz DarkUnification/*
cd "${install_dir}"

/usr/bin/kpackagetool5 -r ~/DarkUnification.tar.gz
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

# Popup Message
/usr/bin/kdialog --title "Please Select 
DarkUnification for GTK 2/3 Theme!
Please Select 
Icon Theme Ultimate Edition Dark Glass!" --passivepopup "This popup will disappear in 15 seconds" 15 &
# GTK Theme setup
/usr/bin/kcmshell5 kde-gtk-config 2>/dev/null

### 
### Copy config files after theme setup
### 

/bin/cp -rf "${install_dir}"/config/* ~/.config
/bin/cp -rf "${install_dir}"/themes/* ~/.themes
sed -i -e s/xxUSERNAMExx/"${user_name}"/g ~/.config/plasmarc

log_entry="${log_heading_2}"
add_to_log

log_entry="${log_heading_4}"
add_to_log

log_entry="${log_heading_1}"
add_to_log

cd /
cd "/home/""${user_name}"
