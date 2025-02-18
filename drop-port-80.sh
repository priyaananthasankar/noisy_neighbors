#!/bin/sh

# Drop port 80
iptables -A INPUT -p tcp --dport 80 -j DROP
echo "Port 80 dropped"

# Sleep for a random number of seconds between 1 and 20
#sleep_time=$(( ( RANDOM % 20 ) + 1 ))
sleep_time=60
echo "Sleeping for $sleep_time seconds"
sleep $sleep_time

# Enable port 80
iptables -D INPUT -p tcp --dport 80 -j DROP
echo "Port 80 enabled"