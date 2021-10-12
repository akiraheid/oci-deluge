#!/bin/bash
# Functions for configuring a server

setupFirewall() {
	echo "Setting up firewall"

	# Any address/port
	UNIVERSE="0.0.0.0/0"

	# The internal interface designation
	INTERFACE="eno1"

	echo "Creating backup..."
	DATE=`date +%Y%m%d-%H%M%S`
	BACKUP=${DATE}-iptables.bak
	NATBACKUP=${DATE}-nat-iptables.bak
	iptables -L -v > $BACKUP
	iptables -L -v -t nat > $NATBACKUP
	echo "Created backups $BACKUP $NATBACKUP"

	echo "Flushing iptables"
	iptables -F
	iptables -X
	iptables -Z
	iptables -F -t nat
	iptables -X -t nat
	iptables -Z -t nat
	echo "Flushing iptables - Done"

	# Logs can be viewed with 'dmesg'
	echo "Creating drop-and-log rule"
	iptables -N drop-and-log
	iptables -A drop-and-log -j LOG --log-level info
	iptables -A drop-and-log -j DROP
	echo "Creating drop-and-log rule - Done"

	echo "Allowing unlimited traffic on loopback"
	iptables -A INPUT -i lo -j ACCEPT
	#iptables -A OUPTUT -o lo -j ACCEPT
	echo "Allowing unlimited traffic on loopback - Done"

	#Loop
    #echo "Allowing OUT as client for port ${PORT}..."
    #iptables -A OUTPUT -o $INTERFACE -p tcp -d $UNIVERSE --dport $PORT -j ACCEPT
    #iptables -A OUTPUT -o $INTERFACE -p udp -d $UNIVERSE --dport $PORT -j ACCEPT
	#Loop
	#FROM=`echo "$PORT" | cut -d ":" -f 1`
	#TO=`echo "$PORT" | cut -d ":" -f 2`
    #echo "  Redirecting ${FROM} => ${TO}..."
	#iptables -A INPUT -i $INTERFACE -p tcp --dport $FROM -j ACCEPT
	#iptables -A INPUT -i $INTERFACE -p udp --dport $FROM -j ACCEPT
	#iptables -A INPUT -i $INTERFACE -p tcp --dport $TO -j ACCEPT
	#iptables -A INPUT -i $INTERFACE -p udp --dport $TO -j ACCEPT
	#iptables -A PREROUTING -t nat -i $INTERFACE -p tcp --dport $FROM -m state --state NEW -j REDIRECT --to-port $TO
	#iptables -A PREROUTING -t nat -i $INTERFACE -p udp --dport $FROM -m state --state NEW -j REDIRECT --to-port $TO

	#echo "Blocking all other ports..."
	#iptables -A INPUT -i $INTERFACE -s $UNIVERSE -d $UNIVERSE -j drop-and-log
	#iptables -A OUTPUT -o $INTERFACE -s $UNIVERSE -d $UNIVERSE -j drop-and-log
	#iptables -A FORWARD -i $INTERFACE -j drop-and-log

	echo "Done"
}
