#!/bin/bash
##
#Scriptimg for backup of log files. on weekly time period
#author- ankit tripathi
#email_id=tankit00@gmail.com
##
day=`date +%d`
month=`date +%m`
year=`date +%Y`
week=$((($(date +%-d)-1)/7+1))
#Backup directory 
back_dir="/backups/log_backup/year-$year/month-$month/week-0$week"
#script Log directory
report_dir="/backups/log_backup/reports"
#if report directory does not exist
if [ ! -d $report_dir ]; then
	mkdir -p $report_dir
fi
#if Backup directory does not exist
if [ ! -d $back_dir ]; then
	mkdir -p $back_dir
fi

#backup function 
backup()
{
 
if [ ! -d $var_dir ];then
	mkdir -p $var_dir
	rsync -r /var/log/$var.*.gz $var_dir 2>> $report_dir/$var && rsync -r /var/log/$var.1 $var_dir  2>> $report_dir/$var
	 
	var1=$?
	if [ $var1 -eq 0 ];then
		echo  "[`date +%d-%m-%Y`]" >> $report_dir/$var
		echo -e "\n var backup done on `date` \n" >> $report_dir/$var 
	else
		echo  "[`date +%d-%m-%Y`]" >> $report_dir/$var
		echo -e "\n backup is not done due to above errors  on `date` \n" >> $report_dir/$var
	fi
	else 
		echo  "[`date +%d-%m-%Y`]" >> $report_dir/$var		
		echo "Backup is Done on Same Week  " >>  $report_dir/$var
fi

}

#for cleaning the log from /var/log after backing up time period(4 weeks)
clean_log()
{

if [ "$week" -eq 4 ];then
	echo "week $week so file deleted from  /var/log/ " >> $report_dir/$var
	rm -rf /var/log/$var.*.gz 
	else 
		echo "week $week so file exists in /var/log/ " >> $report_dir/$var
fi

}

#for auth.log files
var="auth.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#for alternatives.log files
var="alternatives.log"
var_dir="$back_dir/$var""_backup"
backup $var_dir
clean_log

#for cron.log files
var="cron.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#for kern.log files
var="kern.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#for daemon.log files
var="daemon.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#for user.log files
var="user.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log

#for sys.log files
var="sys.log"
var_dir="$back_dir/$var""_backup"
backup 
clean_log


