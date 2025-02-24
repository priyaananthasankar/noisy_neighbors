#!/bin/bash

# Step 1: SSH into minikube node
minikube ssh << EOF

while true; do
  # Step 2: Drop port 80 traffic
  sudo iptables -A KUBE-SERVICES -p tcp --dport 80 -j DROP
  echo "Dropped port 80 traffic"
  
  # Sleep for 1 min
  sleep 60

  # Step 3: Enable port 80 traffic
  sudo iptables -D KUBE-SERVICES -p tcp --dport 80 -j DROP
  echo "Enabled port 80 traffic"
  
  # Sleep for 1 min
  sleep 60
done

EOF