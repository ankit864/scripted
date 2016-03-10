#!/bin/bash
var=`date "+%y-%d-%m-%H:%M:%S"`
image_directory=/home/$USER/image
mkdir -p $image_directory
#check_image=`uptime -s | awk '{print $1"-"$2 }'`
#up_time=`uptime -p | awk '{print $2 }'`
#if [  ] 
streamer -f jpeg -o $image_directory/$var.jpeg
  
