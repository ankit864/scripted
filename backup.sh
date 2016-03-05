#!/bin/bash

day=`date +%d`
month=`date +%m`
year=`date +%Y`
week=$((($(date +%-d)-1)/7+1))
#echo -e "$day\n$month\n$year\n$week"
back_dir="/backups/log_backup/year-$year/month-$month/week-0$week"
report_dir="/backups/log_backup/reports"
if [ ! -d $report_dir ]; then
	mkdir -p $report_dir
fi

#echo $back_dir
if [ ! -d $back_dir ]; then
	mkdir -p $back_dir
fi
 
backup()
{
 
if [ ! -d $var_dir ];then
	mkdir -p $var_dir
	rsync -r /var/log/$var.*.gz $var_dir 2>> $report_dir/$var.txt && rsync -r /var/log/$var.1 $var_dir  2>> $report_dir/$var.txt
	 
 
	var1=$?
	if [ $var1 -eq 0 ];then
		echo  "[`date +%d-%m-%Y`]" >> $report_dir/$var.txt
		echo -e "\n var backup done on `date` \n" >> $report_dir/$var.txt 
	else
		echo  "[`date +%d-%m-%Y`]" >> $report_dir/$var.txt
		echo -e "\n backup is not done due to above errors  on `date` \n" >> $report_dir/$var.txt
	fi
	else 
		echo  "[`date +%d-%m-%Y`]" >> $report_dir/$var.txt		
		echo "Backup is Done on Same Day `date` " >>  $report_dir/$var.txt
fi

}
#'
}

var="auth.log"
var_dir="$back_dir/$var""_backup"
clean_log 
#echo $var_dir
#: '
backup $var_dir

#if [ 1 -eq 1 ];then
var="alternatives.log"
var_dir="$back_dir/$var""_backup"
clean_log
#

#backup $var_dir
#echo $var_dir
#fi
var="cron.log"
var_dir="$back_dir/$var""_backup"
backup $var_dir
#
var="kern.log"
var_dir="$back_dir/$var""_backup"
backup $var_dir
#
var="daemon.log"
var_dir="$back_dir/$var""_backup"
backup $var_dir
#
var="user.log"
var_dir="$back_dir/$var""_backup"
backup $var_dir
#
var="sys.log"
var_dir="$back_dir/$var""_backup"
backup $var_dir


