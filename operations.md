This Documentation extensively covers every details about this assessment. From App Deployment, Monitoring, IAC to Operations

This documentations assumes you already have kubernetes and kubectl installed. w

## Infrastructure

Terraform is being used to provision a VPC and kubernetes cluster on AWS EKS. The below commands init, plan, and applys the terraform codes

Ensure the AWS user account is already configured with required role and permissions

Intiate the terraform modules
```
terraform init
```

terraform plan and output plan to a plan.out file
```
terraform plan -out plan.out
```
Deploy infra
```
terraform apply plan.out
```

# Rayda Deployment

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

```sh
docker run -p 7080:7080 -v ./config.json:/app/loadbalancer/config.json --name loadbalancer -d ghcr.io/vickysomtee/loadbalancer
 ```

## Clone repository
Requirements
- Go installed
- `config.json` file

Clone the Repository to your local directory
```sh
git clone https://github.com/Vickysomtee/loadbalancer.git
```

Build an executable
```sh
cd loadbalancer
go build
```
Run the executable 
```sh
./loadbalancer -config=config.json
```

Note: If you created your `config.json` file in the current working directory, there is no need to specify the config argument. Run the executable using

```sh
./loadbalancer
```

### Contributing
Contributions are welcome! Please submit a pull request or create an issue to contribute to this project.


