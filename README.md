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
## Initialize backend for each environment  
terraform init -backend-config=environments/dev/backend.tf  

## Plan the deploymment
terraform plan -var-file=environments/dev/dev.tfvars

## Apply the deployment
terraform apply -var-file=environments/dev/dev.tfvars -auto-approve