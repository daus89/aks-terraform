# aks-terraform
Terraform for Azure AKS infrastructure


## Initialize backend for each environment
terraform init -backend-config=environments/dev/backend.tf

## Plan the deploymment
terraform plan -var-file=environments/dev/terraform.tfvars

## Apply the deployment
terraform apply -var-file=environments/dev/terraform.tfvars -auto-approve