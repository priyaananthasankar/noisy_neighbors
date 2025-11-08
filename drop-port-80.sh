#!/bin/bash

# Step 1: SSH into minikube node
minikube ssh << EOF

while true; do
  # Step 2: Drop port 80 traffic in FORWARD chain (affects pod-to-pod traffic)
  sudo iptables -I FORWARD 1 -p tcp --dport 80 -j DROP
  echo "Dropped port 80 traffic in FORWARD chain"
  
  # Sleep for 30 seconds to observe the drop
  sleep 30

  # Step 3: Enable port 80 traffic
  sudo iptables -D FORWARD -p tcp --dport 80 -j DROP
  echo "Enabled port 80 traffic"
  
  # Sleep for 30 seconds before next cycle
  sleep 30
done

EOF