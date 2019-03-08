echo "Login Report of All Users"
last -f /var/log/wtmp.1 | awk '{print $1 ": " $5 " " $6 " " $7}' 

echo " "

echo "Last Boot time is: "
	who -b

echo " "

echo "Last Reboot time is: "
last reboot | head -1


echo " "

echo "Last shutdown time is: "
last -x | grep shutdown | head -1
