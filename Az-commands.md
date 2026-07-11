1. Login in to Azure CLI:
    ```az login```

2. Create a resource group for Terraform state storage: 
    ```az group create --name tfstate --location eastus```
3. Create an Azure storage account:

   ``az storage account create --resource-group tfstate --name <unique-storage-account-name> --sku Standard_LRS --encryption-services blob``
4. Create a blob container: 
    ```az storage container create --name tfstate --account-name <storage-account-name>```
5. Create a service principal and generate its credentials: 
    
    ```az ad sp create-for-rbac --name "TerraformSP" --role contributor --scopes /subscriptions/<subscription-id> --sdk-auth```