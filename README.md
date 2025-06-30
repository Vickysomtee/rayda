This Documentation extensively covers every details about this assessment. From App Deployment, Monitoring, IAC to Operations

This documentations assumes you already have kubernetes and kubectl installed. w

## Infrastructure

Terraform is being used to provision a VPC and kubernetes cluster on AWS EKS. 

## Rayda Deployment

To begin with the deployment, first apply the namespace manifest to create a namespace for the deployment.

Deploy Namespace
```
kubectl apply -f k8s/namespace.yaml
```

Deploy Applications Manifest
```
kubectl apply -f k8s/deployment.yaml -f service.yaml -f serviceaccount.yaml
```

The `serviceaccount.yml` creates a service account for the pods.
At this stage, a loadbalancer is already created on AWS to access the app on the browser as the `service.yaml` uses a loadbalancer service type

```
## Monitoring Stack

The kube-prometheus-stack is used for monitoring the kubernetes clusters, nodes, resources. The `deploy.sh` script in the monitoring folder deploys the kube-prometheus stack to the kubernetes cluster using helm.

```sh
bash monitoring/deploy.sh
```


