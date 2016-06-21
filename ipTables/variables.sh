#!/bin/bash
# enter command ./variable.sh TASKNB

INT_IF=wlan0
EXT_IF=wlan1
IS_ALWD=104.16.80.125
MAC_CLIENT=ac:bc:32:a5:3e:ed

if [ $1 = 1 ]; then
	echo "Task 1 - Deny FORWARD by default"
	iptables -I FORWARD 1 -i $INT_IF -o $EXT_IF -j DROP # is the 'EXT_IF' necesasry?
fi

if [ $1 = 2 ]; then
	echo "Task 2 - Allow free forwarding for $IS_ALWD"  #   <<<<< DOES NOT WORK... WHY?
	iptables -t nat -I PREROUTING -i $INT_IF -d $IS_ALWD -j ACCEPT
	iptables -I FORWARD 1 -i $INT_IF -d $IS_ALWD -j ACCEPT
fi

if [ $1 = 3 ]; then
	echo "Task 3 -Allow client to connect (authentified by MAC address)"
	iptables -t nat -I PREROUTING -m mac --mac-source $MAC_CLIENT -j ACCEPT
	iptables -I FORWARD -m mac --mac-source $MAC_CLIENT -j ACCEPT
fi
