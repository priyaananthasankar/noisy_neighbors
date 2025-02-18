#!/bin/bash

# Specify the namespace to check
namespace="default"

# Get the list of all pods in the specified namespace
pods=$(kubectl get pods -n $namespace -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}')

# Loop through each pod and query the logs
echo "Checking logs of all pods in namespace $namespace for 'Port 80 dropped' message..."
for name in $pods; do
  echo "Checking logs for pod $name..."
  kubectl logs -n $namespace $name | grep "dropped"
done