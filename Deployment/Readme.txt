Current terraform will create 2 webapp and sql db. gateway is still to create.
Systemflow is in flowdesign.jpg

Below commands to run terraform.
terraform init -backend-config="resource_group_name=<storage account rg>" -backend-config="storage_account_name=<storage account name>" -backend-config="key=terraform.deployment.tfplan"
terraform workspace select/new dev 
terraform validate
terraform plan -out -var "sql_administrator_login=<abc>" -var  "sql_administrator_login_password=<abc>" "terraform.deployment.tfplan"
terraform apply terraform.deployment.tfplan