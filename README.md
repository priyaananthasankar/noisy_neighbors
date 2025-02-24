# Noisy Neighbors Simulation

This project simulates a noisy neighbor issue in a Kubernetes cluster by spinning up some healthy pods and intermittently yanking off the network connections of the node that affects all pods. This is achieved by manipulating `iptables` rules to drop traffic on specific ports, and muting kube-proxy that takes control of iptables.

## Prerequisites:

1. Install and setup [Minikube](https://minikube.sigs.k8s.io/docs/)
2. Build docker images, for server and client

`docker build -t fruitflies:latest -f <path to Dockerfile> .`

`docker build -t ff-client:latest -f <path to ff_client_dockerfile> .`

## Steps to Simulate Noisy Neighbor Issue

1. **Start Minikube with `kube-proxy` disabled:**

`minikube start` (or) `minikube start --extra-config=kube-proxy.enabled=false` (starts with kube-proxy disabled)

2. **Delete the kube-proxy DaemonSet**

`kubectl delete daemonset kube-proxy -n kube-system`

3. **Load required images into minikube**

```sh
minikube image load fruitflies:latest
minikube image load ff-client:latest
```

4. **Create deployments**

```sh
kubectl apply -f ./deployments/fruitflies-config.yaml

kubectl apply -f ./deployments/fruitflies.yaml
```

5. **Check if pods are running**

`kubectl get pods -o wide`

6. **Drop the ports**

Run the drop-port-80.sh script in a terminal

`./utils/drop-port-80.sh`

7. **Verify logs**

In a separate terminal, tail the logs of ff-client pod

`kubectl logs -f <pod_name>`

where pod_name is one of the ff-client pods

Observe the terminal opened in step 6, the disconnect will show up as `Error calling http://fruitflies-service:80: Request timed out` in the pod logs.

**Explanation**

This project demonstrates how network issues can be simulated in a Kubernetes cluster.

By manipulating iptables rules, we can intermittently drop traffic on specific ports, simulating network disruptions caused by noisy neighbors.

The fruitflies service is used as an example, and the ff-client pod continuously makes requests to the fruitflies service. By dropping traffic on port 80, we can observe how the ff-client pod handles network disruptions.

## References

Kube-proxy: [What is it and how it works](https://medium.com/@amroessameldin/kube-proxy-what-is-it-and-how-it-works-6def85d9bc8f)
