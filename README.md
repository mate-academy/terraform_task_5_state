# Configuring Remote State in Terraform

Transition from a local Terraform state file to a remote state backend in Azure Blob Storage. This setup is essential for collaborative infrastructure management, ensuring that the state is safely stored and accessible by the entire team.

## Prerequisites

To complete this task, you must have:
- Terraform installed (version 1.8.4 or later)
- Azure CLI installed and configured
- An Azure subscription


## Steps to Complete the Task

**1. Fork this Repository**

**2. Create a Service Principal in Azure**

- Log in to Azure CLI:
   ```bash
   az login
   ```
- Create a resource group for Terraform state storage:
   ```bash
   az group create --name tfstate --location eastus
   ```
- Create an Azure storage account:
   ```bash
   az storage account create --resource-group tfstate --name <unique-storage-account-name> --sku Standard_LRS --encryption-services blob
   ```
- Create a blob container:
   ```bash
   az storage container create --name tfstate --account-name <storage-account-name>
   ```
- Create a service principal and generate its credentials:
   ```bash
   az ad sp create-for-rbac --name "TerraformSP" --role contributor --scopes /subscriptions/<subscription-id> --sdk-auth
   ```

**3. Configure GitHub Secrets**

Add the following secrets to your GitHub repository:

   * `AZURE_CLIENT_ID`: The client ID of the managed identity 
      ```bash
      az identity show --name TerraformMSI --resource-group tfstate --query clientId -o tsv
      ```
   * `AZURE_SUBSCRIPTION_ID`: Your Azure subscription ID
      ```bash
      az account show --query id -o tsv
      ```
   * `AZURE_TENANT_ID`: Your Azure tenant ID
      ```bash
      az account show --query tenantId -o tsv
      ```

**4. Set Up Local Backend**

- Create an initial `main.tf` file with a basic setup for the local backend and Azure provider.
- Initialize Terraform to use the local backend.

**5. Transition to Remote State Backend**

- Modify your main.tf file to include the Azure backend configuration.
- Use `use_oidc = true` setting in both the backend and provider blocks for enabling OIDC authentication with Azure.

**6. Verify the Remote State Configuration**

- Run Terraform plan and apply commands to verify the setup.
- Check the Azure Blob Storage to ensure the `terraform.tfstate` file is stored there.

**7. Pull request's description should also contain a reference to a successful workflow run**

## Implemented configuration

The final configuration is split into four files:

- `backend.tf` selects Azure Blob Storage as the Terraform backend;
- `provider.tf` configures AzureRM to use GitHub OIDC;
- `main.tf` creates a cost-free built-in `terraform_data` state marker;
- `outputs.tf` prints the marker read from Terraform state.

The backend uses the following Azure objects:

```text
Resource group:  tfstate
Storage account: amajlotfstate5
Container:       tfstate
State blob:      terraform-task-5.tfstate
```

Backend arguments cannot use normal Terraform input variables because the
backend is initialized before Terraform evaluates variables and resources.

## 1. Create the backend storage

The storage account name above has been checked for global availability. Create
the backend objects before running `terraform init` with the remote backend:

```bash
az login
az group create --name tfstate --location northeurope

az storage account create \
  --resource-group tfstate \
  --name amajlotfstate5 \
  --location northeurope \
  --sku Standard_LRS \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false

az storage container create \
  --name tfstate \
  --account-name amajlotfstate5 \
  --auth-mode login
```

## 2. Demonstrate local-to-remote state migration

To demonstrate the transition required by the task, temporarily comment out the
entire `backend "azurerm"` block in `backend.tf`, then run:

```bash
terraform init
terraform apply
terraform state list
```

Uncomment the backend block. For this local migration, override OIDC so the
backend uses the current Azure CLI login:

```bash
terraform init -migrate-state -backend-config="use_oidc=false"
```

Answer `yes` when Terraform asks whether it should copy the existing state to
Azure. Verify the blob:

```bash
az storage blob list \
  --account-name amajlotfstate5 \
  --container-name tfstate \
  --auth-mode login \
  --query "[].name" \
  --output table
```

The result should contain `terraform-task-5.tfstate`.

## 3. Configure GitHub OIDC

The workflow already requests an OIDC token and maps these repository secrets
to the standard Azure environment variables:

- `AZURE_CLIENT_ID`;
- `AZURE_SUBSCRIPTION_ID`;
- `AZURE_TENANT_ID`.

The corresponding Azure application or managed identity must have a federated
credential that trusts this GitHub repository. It also needs the
`Storage Blob Data Contributor` role for the storage account. A normal
`Contributor` role alone does not grant access to Blob data.

Create the Service Principal, assign the required roles, and register the
included `github-federated-credential.json` trust policy:

```bash
subscription_id=$(az account show --query id --output tsv)

client_id=$(az ad sp create-for-rbac \
  --name TerraformSP-task5 \
  --skip-assignment \
  --query appId \
  --output tsv)

principal_id=$(az ad sp show \
  --id "$client_id" \
  --query id \
  --output tsv)

storage_scope=$(az storage account show \
  --resource-group tfstate \
  --name amajlotfstate5 \
  --query id \
  --output tsv)

az role assignment create \
  --assignee-object-id "$principal_id" \
  --assignee-principal-type ServicePrincipal \
  --role Contributor \
  --scope "/subscriptions/$subscription_id"

az role assignment create \
  --assignee-object-id "$principal_id" \
  --assignee-principal-type ServicePrincipal \
  --role "Storage Blob Data Contributor" \
  --scope "$storage_scope"

az ad app federated-credential create \
  --id "$client_id" \
  --parameters @github-federated-credential.json
```

Add the three non-secret identifiers to the fork repository. With GitHub CLI:

```bash
tenant_id=$(az account show --query tenantId --output tsv)

gh secret set AZURE_CLIENT_ID --body "$client_id"
gh secret set AZURE_SUBSCRIPTION_ID --body "$subscription_id"
gh secret set AZURE_TENANT_ID --body "$tenant_id"
```

The included federated credential trusts workflow runs from `main` in the
`aleksandrmajlo/terraform_task_5_state` fork. A pull request targeting the
academy repository does not receive the fork's secrets; that is safe here
because the pull-request workflow uses `terraform init -backend=false`.

Do not create or store an `AZURE_CLIENT_SECRET`: OIDC exchanges GitHub's
short-lived identity token for an Azure token and therefore avoids a permanent
cloud secret in GitHub.

## 4. Validate and submit

The pull-request workflow intentionally disables backend initialization, so it
can validate forked pull requests without access to Azure credentials:

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

After the workflow succeeds, add its URL to the pull request description as
required by the task.
