#!/bin/bash
#script for file information

file_info 
{

if [ ! -e "$1" ]; then
	echo "File $1 does not exist."
	#exit 1
fi
if [ -d "$1" ]; then
  	echo -n "$1 is a Directory that you may "
	if [ ! -x "$1" ]; then
	echo -n "not"
	fi
	echo -n "search."
elif [ -f "$1" ]; then
	echo "$1 is regular file."
else
	echo "$1 is special type file." 
fi
if [ -O "$1" ]; then 
	echo "you own the file."
else 
	echo "you do not own the file." 
fi
if [ -r "$1" ]; then
	echo "you have read permission on the file. "
fi
if [ -w "$1" ]; then
	echo "you have write permission on the file. "
fi
if [ -x "$1" ]; then
	echo "you have execute permission on the file. "
fi 
}

for filename in "$@" ; do
	file_info "$filename"
	echo
done

