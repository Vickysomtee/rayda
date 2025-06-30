This Documentation extensively covers every details about this assessment. From App Deployment, Monitoring, IAC to Operations

This documentations assumes you already have kubernetes and kubectl installed.

## Infrastructure

Terraform is being used to provision a VPC and kubernetes cluster on AWS EKS. In this case there is CI/CD pipeline in the `.github/workflows` folder to automate the entire terraform deployment which can only be triggered manually.

## Rayda Deployment

To begin with the deployment, first apply the namespace manifest to create a namespace as well as certain pod security rule at the namespace level for the deployment.

Deploy Namespace
```
kubectl apply -f k8s/namespace.yaml
```

Deploy Application Manifest
```
kubectl apply -f k8s/deployment.yaml -f service.yaml -f serviceaccount.yaml
```

The `serviceaccount.yml` creates a service account for the pods.

At this stage, a loadbalancer is already created on AWS to access the app on the browser as the `service.yaml` uses a loadbalancer service type


## Monitoring Stack

The kube-prometheus-stack is used for monitoring the kubernetes clusters, nodes, resources. The `deploy.sh` script in the monitoring folder deploys the kube-prometheus stack to the kubernetes cluster using helm.

```sh
bash monitoring/deploy.sh
```

# Operations

Below are required operations to support the kubernester cluster.

### Role Based access control

The below command gives the service account that was created earlier a read only access to the running pod

```
kubectl apply -f k8s/security/rabac.yaml
```

### Cluster tear down
The `clean-up.sh` file is implemented for a graceful teardown of the infrastructure. This ensures that every single resource in AWS is deleted.

```sh
bash terraform/clean-up.sh
```





