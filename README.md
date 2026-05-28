# Secure Terraform Remote State (Azure & OIDC)

## 📖 Project Overview
This project demonstrates the transition from a local Terraform state to a secure, centralized remote backend using Azure Blob Storage. This architectural shift is essential for collaborative Infrastructure as Code (IaC) management, ensuring state file consistency, preventing concurrent modification conflicts, and securing sensitive infrastructure data.

## 🛠 Architecture & Tech Stack
* **Infrastructure as Code (IaC):** Terraform (v1.8+)
* **Cloud Provider:** Microsoft Azure
* **State Storage:** Azure Blob Storage
* **Authentication:** OpenID Connect (OIDC), Azure Service Principal
* **CI/CD & Automation:** GitHub Actions, Azure CLI

## ⚙️ Implementation Details
The remote state migration involved the following engineering steps:
1. **Storage Provisioning:** Created a dedicated Azure Resource Group and an Azure Storage Account with a blob container (`tfstate`) specifically isolated for state file management.
2. **Identity & Access Management (IAM):** Configured an Azure Service Principal with explicit Role-Based Access Control (RBAC) permissions to interact with the storage account.
3. **Passwordless Authentication (OIDC):** Integrated Azure with GitHub Actions using OIDC (`use_oidc = true`). This eliminated the need to store long-lived cloud credentials, utilizing short-lived tokens via GitHub Secrets (`AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`).
4. **Backend Transition:** Successfully initialized a local Terraform backend and migrated it to the Azure remote backend without data loss.

## 🔐 Security & Validation
* Verified the successful creation and locking of the `terraform.tfstate` file within the Azure Blob Storage container.
* Validated the authentication flow through a successful CI/CD workflow run in GitHub Actions, confirming the OIDC integration operates correctly.

## 📝 Code Review & Approval
This infrastructure configuration has been thoroughly reviewed and validated by a Senior DevOps Engineer. The review ensured adherence to security best practices, proper IAM configuration, and successful remote state integration.

You can view the full discussion, implementation, and final approval in the **[Pull Request #43](https://github.com/mate-academy/terraform_task_5_state/pull/43)**.
