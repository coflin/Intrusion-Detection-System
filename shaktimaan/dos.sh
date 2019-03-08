#!/bin/bash
first="$(echo `hostname -I | awk '{print $1}'` | cut -d'.' -f1)"
second="$(echo `hostname -I | awk '{print $1}'` | cut -d'.' -f2)"
third="$(echo `hostname -I | awk '{print $1}'` | cut -d'.' -f3)"
fourth="$(echo `hostname -I | awk '{print $1}'` | cut -d'.' -f4)"

if [[ $first -ge 1 && $first -le 126 ]]
then
        ip_add=$first".0.0.0/24"

elif [[ $first -ge 128 && $first -le 191 ]]
then
        ip_add=$first"."$second".0.0/24"

elif [[ $first -ge 192 && $first -le 223 ]]
then
        ip_add=$first"."$second"."$third".0/24"

fi

ip_array=($(sudo nmap -sP $ip_add | grep -E -o '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'))
mac_array=($(sudo nmap -sP $ip_add | grep "MAC Address" | awk '{print $3}' ))
ip_len=${#ip_array[@]}
for (( i=1; i<$ip_len; i++ ))
do
	if [ ${ip_array[$i]} != `hostname -I | awk '{print $1}'` ]
	then
		echo ${ip_array[$i]}
		sudo timeout 10 tshark -i wlan0 -Y "ip.src == `hostname -I | awk '{print $1}'` && ip.dst == ${ip_array[$i]}" >> /etc/shaktiman/logs/DOS	
		grep -a SYN log1
		if [ $? -eq 0 ]
		then
			echo ${ip_array[$i]}  "Is the attacker will block this "
			sudo iptables -A INPUT -s ${ip_array[$i]} -j DROP
		else
			echo "You are safe and sound"
		fi
	fi
done
