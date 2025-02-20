# aks-terraform
This Terraform project is to deploy a simple Azure and AKS infrastructure to host a simple web application.

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


To see error, use TF_LOG=DEBUG before the tf command, example  
``` TF_LOG=DEBUG terraform plan -var-file=environments/dev/dev.tfvars  

To destroy resources for specific environment:  
``` terraform destroy -var-file=environments/dev/dev.tfvars

To initialize, plan and provision the resources per environment:

For Dev Env
``` terraform init -reconfigure -backend-config="path=environments/dev/terraform.tfstate"  
``` terraform plan -var-file=environments/dev/dev.tfvars
``` terraform apply -var-file=environments/dev/dev.tfvars 

For QA Env
``` terraform init -reconfigure -backend-config="path=environments/qa/terraform.tfstate"  
``` terraform plan -var-file=environments/qa/qa.tfvars   
``` terraform apply -var-file=environments/qa/qa.tfvars  

For Prod Env
``` terraform init -reconfigure -backend-config="path=environments/prod/terraform.tfstate"  
``` terraform plan -var-file=environments/prod/prod.tfvars
``` terraform apply -var-file=environments/prod/prod.tfvars

# Challenges  
1. tfstate file stored in root folder instead of environments folder. Still troubleshooting  

2. Overlapped CIDR for AKS and k8s Service CIDR. Resolved by added into modules/k8s/main.tf and declare different CIDR in tfvars file
``` network_profile {
    network_plugin = "azure"
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip 
  }  


# K8s commands from local workstation

1. Install Azure AKS k8s CLI
``` az aks install-cli

2. Login to azure account and set subscription ID
``` az login
``` az account set --subscription "<SUBSCRIPTION ID>"

3. Get AKS resource group and AKS cluster name
``` az aks list --query '[].{name:name, resourceGroup:resourceGroup}' -o table

4. Get AKS credentials and merged the login info automatically into local kubeconfig file
``` az aks get-credentials --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME>

5. Verify connection to the AKS cluster
``` kubectl config current-context
``` kubectl get nodes
``` kubectl get pods -A 

