#!/bin/bash
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "@reboot sleep 10; /etc/Intrusion-Detection-System/shaktimaan/Reports.sh > /etc/Intrusion-Detection-System/shaktimaan/logs/BootReports" >> mycron 
echo "@reboot sleep 10; /etc/Intrusion-Detection-System/shaktimaan/ShutDownreport.sh > /etc/Intrusion-Detection-System/shaktimaan/logs/ShutdownReport" >> mycron 
echo "@reboot sleep 10; /etc/Intrusion-Detection-System/shaktimaan/RebootReport.sh > /etc/Intrusion-Detection-System/shaktimaan/logs/RebootReport" >> mycron 
echo "*/2 * * * * /etc/Intrusion-Detection-System/shaktimaan/dos.sh" >> mycron 
echo "@reboot /etc/Intrusion-Detection-System/shaktimaan/encrypt" >> mycron
echo "@reboot /etc/Intrusion-Detection-System/shaktimaan/fksencrypt" >> mycron
#install new cron file
crontab mycron
rm mycron
