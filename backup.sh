#!/bin/bash

day=`date +%d`
month=`date +%m`
year=`date +%Y`
week=$((($(date +%-d)-1)/7+1))
back_dir="/backups/log_backup/year-$year/month-$month/week-0$week"
report_dir="/backups/log_backup/reports"
if [ ! -d $report_dir ]; then
	mkdir -p $report_dir
fi


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

clean_log()
{

if [ "$week" -eq 4 ];then
	echo "week $week so file deleted from  /var/log/ " >> $report_dir/$var.txt
	rm -rf /var/log/$var.*.gz 
	else 
		echo "week $week so file exists in /var/log/ " >> $report_dir/$var.txt
fi

}

var="auth.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

var="alternatives.log"
var_dir="$back_dir/$var""_backup"
backup $var_dir
clean_log

var="cron.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log
#
var="kern.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#
var="daemon.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#
var="user.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#
var="sys.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log


