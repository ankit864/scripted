#!/bin/bash

root_check=`id -u`
if [ root_check -eq 0 ]; then
    read -p "Enter username for New User : "username 
    read -s -p "Enter password : " password
    egrep "^$username" /etc/passwd 
    if [ $? -eq 0 ]; then
        echo "$username exists! please try another user name"
        exit 
    else
        pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
        useradd -m -p $pass $username
        [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
    fi
else
    echo "Only root may add a user to the system"
    exit 2
fi
