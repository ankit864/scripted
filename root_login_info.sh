#!/bi/bash
#
#script for informtion of failed login as root from users and total number of login as root
#author= "Ankit tripathi"
#date= 02-nov-2015
#
cat  /var/log/auth.log* >> /tmp/auth.log
#cat  /var/log/auth.log >> /tmp/auth.log
zcat /var/log/auth.log.*.gz >> /tmp/auth.log
echo "=========%Number of FAILED attempts for login as ROOT%========" 
var2=$(cat /tmp/auth.log | grep -c  "FAILED")
echo "Total failed attempts of login -->> $var2" 
var1=$(cat /tmp/auth.log | grep -c  "FAILED su for root by $(hostname)")
echo "failed attempt by user $(hostname)   -->>  $var1"
var3=`expr $var2 - $var1`
echo "failed attempt by user unknown -->>  $var3"
var4=$(cat /tmp/auth.log | grep  -c  "New seat seat0")
echo
echo "number of times system power up $var4"
var5=$(cat /tmp/auth.log | grep  -c  " Successful su for root by $(hostname)")
echo "number of succesfull root login by $(hostname) $var5"
rm /tmp/auth.log
