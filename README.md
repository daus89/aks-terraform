# aks-terraform
This Terraform project is to deploy a simple Azure and AKS infrastructure to host a simple web application.

## 🛠️ **Prerequisites**
Ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (`>=1.0.0`)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## 🚀 **Deployment Steps**
### **1️⃣ Initialize Terraform for an Environment**
Run the following command from the root directory:

```sh
terraform init -backend-config=environments/dev/backend.tf

Components or Azure services being deployed:
1. vnet, subnets (public,private) and network security group
2. Azure AKS
3. Azure Load Balancer in public subnet

To give better isolation, modularity for this TF project, folder will be structured as below:

aks-terraform/  
|--- main.tf    # Contain TF root configuration, including modules  
|--- variables.tf # Global variables  
|--- provider.tf # contains azure and k8s provider  
|--- environments/ # Environment specific configuration  
| |---dev/  
| |---qa/  
| |---prod/  
|--- modules/ # Contains shared modules
| |---aks/  
| |---k8s/  
| |---load_balancer/  
| |---networking/  
| |---resource_group/  


# Terraform commands

## Deployment Steps

To deploy the resources for each environment, follow these steps:

### Dev Environment
1. Initialize Terraform for the Dev environment:
```sh
terraform init -reconfigure -backend-config="path=environments/dev/terraform.tfstate"
```
2. Plan the deployment for the Dev environment:
```sh
terraform plan -var-file=environments/dev/dev.tfvars
```
3. Apply the deployment for the Dev environment:
```sh
terraform apply -var-file=environments/dev/dev.tfvars
```

### QA Environment
1. Initialize Terraform for the QA environment:
```sh
terraform init -reconfigure -backend-config="path=environments/qa/terraform.tfstate"
```
2. Plan the deployment for the QA environment:
```sh
terraform plan -var-file=environments/qa/qa.tfvars
```
3. Apply the deployment for the QA environment:
```sh
terraform apply -var-file=environments/qa/qa.tfvars
```

### Prod Environment
1. Initialize Terraform for the Prod environment:
```sh
terraform init -reconfigure -backend-config="path=environments/prod/terraform.tfstate"
```
2. Plan the deployment for the Prod environment:
```sh
terraform plan -var-file=environments/prod/prod.tfvars
```
3. Apply the deployment for the Prod environment:
```sh
terraform apply -var-file=environments/prod/prod.tfvars
```

To see detailed error logs, you can use `TF_LOG=DEBUG` before running the Terraform commands. For example:
```sh
TF_LOG=DEBUG terraform plan -var-file=environments/dev/dev.tfvars
```

To destroy resources for a specific environment, use the following command:
```sh
terraform destroy -var-file=environments/dev/dev.tfvars
```

# Challenges  
1. tfstate file stored in root folder instead of environments folder. Still troubleshooting  

# aks-terraform
This Terraform project is to deploy a simple Azure and AKS infrastructure to host a simple web application.

## 🛠️ Prerequisites
Ensure you have the following installed:
- [Terraform](https://developer.hashicorp.com/terraform/downloads) (`>=1.0.0`)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## 🚀 Deployment Steps
### 1️⃣ Initialize Terraform for an Environment
Run the following command from the root directory:
```sh
terraform init -backend-config=environments/dev/backend.tf
```

Components or Azure services being deployed:
1. vnet, subnets (public,private) and network security group
2. Azure AKS
3. Azure Load Balancer in public subnet

To give better isolation and modularity for this Terraform project, the folder structure is as follows:
```
aks-terraform/  
|--- main.tf    # Contains TF root configuration, including modules  
|--- variables.tf # Global variables  
|--- provider.tf # Contains Azure and Kubernetes provider  
|--- environments/ # Environment specific configuration  
| |---dev/  
| |---qa/  
| |---prod/  
|--- modules/ # Contains shared modules
| |---aks/  
| |---k8s/  
| |---load_balancer/  
| |---networking/  
| |---resource_group/  
```

## Terraform Commands
### Deployment Steps
To deploy the resources for each environment, follow these steps:

### Dev Environment
1. Initialize Terraform for the Dev environment:
```sh
terraform init -reconfigure -backend-config="path=environments/dev/terraform.tfstate"
```
2. Plan the deployment for the Dev environment:
```sh
terraform plan -var-file=environments/dev/dev.tfvars
```
3. Apply the deployment for the Dev environment:
```sh
terraform apply -var-file=environments/dev/dev.tfvars
```

### QA Environment
1. Initialize Terraform for the QA environment:
```sh
terraform init -reconfigure -backend-config="path=environments/qa/terraform.tfstate"
```
2. Plan the deployment for the QA environment:
```sh
terraform plan -var-file=environments/qa/qa.tfvars
```
3. Apply the deployment for the QA environment:
```sh
terraform apply -var-file=environments/qa/qa.tfvars
```

### Prod Environment
1. Initialize Terraform for the Prod environment:
```sh
terraform init -reconfigure -backend-config="path=environments/prod/terraform.tfstate"
```
2. Plan the deployment for the Prod environment:
```sh
terraform plan -var-file=environments/prod/prod.tfvars
```
3. Apply the deployment for the Prod environment:
```sh
terraform apply -var-file=environments/prod/prod.tfvars
```

To see detailed error logs, you can use `TF_LOG=DEBUG` before running the Terraform commands. For example:
```sh
TF_LOG=DEBUG terraform plan -var-file=environments/dev/dev.tfvars
```

To destroy resources for a specific environment, use the following command:
```sh
terraform destroy -var-file=environments/dev/dev.tfvars
```

# Challenges  
1. tfstate file stored in root folder instead of environments folder. Still troubleshooting  

2. Overlapped CIDR for AKS and k8s Service CIDR. Resolved by adding into `modules/k8s/main.tf` and declaring different CIDR in the `tfvars` file.

# K8s commands from local workstation

1. Install Azure AKS k8s CLI
```sh
az aks install-cli
```

2. Login to Azure account and set subscription ID
```sh
az login
az account set --subscription "<SUBSCRIPTION ID>"
```

3. Get AKS resource group and AKS cluster name
```sh
az aks list --query '[].{name:name, resourceGroup:resourceGroup}' -o table
```

4. Get AKS credentials and merge the login info automatically into the local kubeconfig file
```sh
az aks get-credentials --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME>
```

5. Verify connection to the AKS cluster
```sh
kubectl config current-context
kubectl get nodes
kubectl get pods -A
```


