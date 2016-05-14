#!/bin/bash

bing="www.bing.com"
pic_url_extract_page="http://www.bing.com/HPImageArchive.aspx?format=xml&idx=1&n=1&mkt=en-US"
wallpaper_dir="/home/$USER/wallpaper"
mkdir -p $wallpaper_dir
pic_resolution="_1366x768"
pic_ext=".jpg"
wallpaper_url=$bing$(echo $(curl -s $pic_url_extract_page) | grep -oP "<urlBase>(.*)</urlBase>" | cut -d ">" -f 2 | cut -d "<" -f 1)$pic_resolution$pic_ext
wallpaper_url_default=$bing$(echo $(curl -s $pic_url_extract_page) | grep -oP "<url>(.*)</url>" | cut -d ">" -f 2 | cut -d "<" -f 1)
if wget --quiet --spider "$wallpaper_url"
then

    name_of_wallpaper=${wallpaper_url##*/}
    # Download the Bing pic of the day at desired resolution
    curl -s -o $wallpaper_dir$name_of_wallpaper $wallpaper_url
else
    # Set name_of_wallpaper to the default name_of_wallpaper
    name_of_wallpaper=${wallpaper_url_default##*/}
    # Download the Bing pic of the day at default resolution
    curl -s -o $wallpaper_dir$name_of_wallpaper $wallpaper_url_default
fi

# Set the GNOME3 wallpaper
gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_dir$name_of_wallpaper"

exit
