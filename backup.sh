#!/bin/bash
day=`date +%d`
month=`date +%m`
year=`date +%Y`
week=$((($(date +%-d)-1)/7+1))
echo -e "$day\n$month\n$year\n$week"
back_dir="/backups/log_backup/year-$year/month-$month/day-$day"
report_dir="/backups/log_backup/reports"
mkdir -p $report_dir
echo $back_dir
if [ ! -d $back_dir ]; then
	mkdir -p $back_dir
fi
#for syslog
syslog_dir="$back_dir/syslog_backup"
if [ ! -d $syslog_dir ];then
	mkdir -p $back_dir/syslog_backup 
fi
rsync -r /var/log/syslog.*.gz $syslog_dir 2>> $report_dir/syslog_backup.txt && rsync -r /var/log/syslog.1 2>> $report_dir/syslog_backup.txt $syslog_dir && rm -rf /var/log/syslog.*.gz 
var1=$?
if [ $var1 -eq 0 ];then
echo -e "[`date +%d-%m-%Y`]\n" 
echo "\nsyslog backup done on `date`\n" >> $report_dir/syslog_backup.txt 
else
echo -e "[`date +%d-%m-%Y`]\n"
echo -e "\nbackup is not done due to above errors  on `date`\n" >> $report_dir/syslog_backup.txt
fi
