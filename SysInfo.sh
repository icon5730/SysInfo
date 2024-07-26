#!/bin/bash

red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
cyan="\e[36m"
endcolor="\e[0m"

printf $red
figlet "SysInfo"
printf $endcolor


echo -e "\n\n$cyan[*]$endcolor$blue Displaying System Info: $endcolor\n" ; sleep 0.3
pip=$(curl ifconfig.me 2>/dev/null)
echo -e "$cyan[+]$endcolor$yellow Public IP Address:$endcolor\n$green$pip$endcolor" ; sleep 0.3
lip=$(hostname -I)
echo -e "$cyan[+]$endcolor$yellow Local IP Address:$endcolor\n$green$lip$endcolor" ; sleep 0.3
gate=$(ip route | grep default | awk '{print $3}')
echo -e "$cyan[+]$endcolor$yellow Default Gateway:$endcolor\n$green$gate$endcolor" ; sleep 0.3
mac=$(ifconfig | grep ether | awk '{print $2}')
echo -e "$cyan[+]$endcolor$yellow Mac Address:$endcolor\n$green$mac$endcolor" ; sleep 0.3
cpu=$(ps -eo pid,%cpu,comm --sort=%cpu | tail -n 6 | head -n 5)
echo -e "$cyan[+]$endcolor$yellow Top 5 processes by CPU usage:$endcolor\n$green$cpu$endcolor" ; sleep 0.3
memtotal=$(free -h | grep Mem: | awk '{print $2}')
memused=$(free -h | grep Mem: | awk '{print $3}')
memfree=$(free -h | grep Mem: | awk '{print $4}')
memshared=$(free -h | grep Mem: | awk '{print $5}')
membuff=$(free -h | grep Mem: | awk '{print $6}')
memavailable=$(free -h | grep Mem: | awk '{print $7}')
echo -e "$cyan[+]$endcolor$yellow Memory usage:$endcolor" ; sleep 0.3
echo -e "$green- Total:$endcolor$red $memtotal$endcolor" ; sleep 0.2
echo -e "$green- Used:$endcolor$red $memused$endcolor" ; sleep 0.2
echo -e "$green- Free:$endcolor$red $memfree$endcolor" ; sleep 0.2
echo -e "$green- Buff/Cache:$endcolor$red $membuff$endcolor" ; sleep 0.2
echo -e "$green- Available:$endcolor$red $memavailable$endcolor" ; sleep 0.2
srv=$(service --status-all 2>/dev/null | grep -F "[ + ]")
echo -e "$cyan[+]$endcolor$yellow Active services:$endcolor\n$green$srv$endcolor" ; sleep 0.3
data=$(du -ah /home | sort -nr | head -n 10)
echo -e "$cyan[+]$endcolor$yellow Top 10 largest files found in /home:$endcolor\n$green$data$endcolor" ; sleep 0.3
echo -e "$cyan[+]$endcolor$yellow CPU Usage (Refreshes every 10 seconds):$endcolor\n"
while true; do
	echo -e "$green$(iostat -c)$endcolor"
	echo -e "\n             $cyan[*]$endcolor$yellow Press $endcolor$blue[Enter]$endcolor$yellow to stop refreshing CPU Usage data: $endcolor"
	read -t 10 user_input
		if [ $? -eq 0 ]; then
			break
		fi
	echo -e "\n$cyan[+]$endcolor$blue Refreshing...$endcolor\n"
done
echo -e "\n$cyan[*]$endcolor$yellow CPU Usage data loop concluded $endcolor"
