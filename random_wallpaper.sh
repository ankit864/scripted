#!/bin/bash
#
#script for random wallpaper for Gnome Dektop Enviornment
#random wallpaper will change after 30 seconds according to sleep time
#author= "Ankit Tripathi"
#date= 07-mar-2016
#
 
#wallpaper dirctory 
wp_dir="/home/$USER/wallpaper"
gnome_check=$(pgrep -l "gnome|kde|mate|cinnamon" | grep "gnome-")
if [[  ! -z $gnome_check ]]; then
while [ 1 ];do
#for random selection of any one pic from Directory
	select_wallpaper=$(ls $wp_dir/* | shuf -n1)
	#picOpts="zoom"
	gsettings set org.gnome.desktop.background picture-uri "file://$select_wallpaper"
	#gsettings set org.gnome.desktop.background picture-options $pic_opts
#sleep for 30 seconds
sleep 30
done

else
	echo "Sorry not Gnome....!!!! " 
fi 



