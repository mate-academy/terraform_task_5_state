# Configuring Remote State in Terraform

Transition from a local Terraform state file to a remote state backend in Azure Blob Storage. This setup is essential for collaborative infrastructure management, ensuring that the state is safely stored and accessible by the entire team.

## Prerequisites

To complete this task, you must have Terraform and Azure CLI installed and configured on your machine.

## Steps to Complete the Task

**1. Fork this Repository**

**2. Create a Service Principal in Azure**

- Run the following command to create a service principal. Replace `<service-principal-name>` with a unique name of your choice and `<subscription-id>` with your Azure subscription ID:

   ```bash
   az ad sp create-for-rbac --name "<service-principal-name>" --role contributor --scopes /subscriptions/<subscription-id> --sdk-auth
   ```
- The command will output a JSON object containing the service principal credentials. Copy this JSON object.

**3. Add the JSON Output to GitHub Secrets**

- Click on `Settings` > `Secrets and variables` > `Actions` > `New repository secret`.
- Name the secrets `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `AZURE_CLIENT_SECRET` and paste the `clientId`, `tenantId`, `subscriptionId`, `clientSecret` from JSON output into the value fields.

**4. Set Up Local Backend**

- Ensure that the initial `main.tf` file includes a basic setup for the local backend.
- Initialize Terraform to use the local backend.

**5. Transition to Remote State Backend**

- Modify `main.tf` to configure the remote backend in Azure.
- Create necessary Azure resources for the backend configuration.
- Apply the configuration to create the necessary Azure resources.
- Initialize Terraform with the new backend configuration, migrating the state from local to remote.

**6. Verify the Remote State Configuration**

- Run Terraform plan and apply commands to verify the setup.
- Check the Azure Blob Storage to ensure the `terraform.tfstate` file is stored there.
