# Azure Blob Storage — Terraform

[![Azure](https://img.shields.io/badge/Azure-Cloud%20Infrastructure-0078D4?logo=microsoftazure&logoColor=white)](https://www.google.com/search?q=Microsoft+Azure+Cloud+Infrastructure)  [![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-7B42BC?logo=terraform&logoColor=white)](https://www.google.com/search?q=Terraform+Infrastructure+as+Code)  [![GitHub](https://img.shields.io/badge/Version%20Control-GitHub-181717?logo=github&logoColor=white)](https://www.google.com/search?q=GitHub+Version+Control)

## 📌 Project Overview

This repository contains Terraform configuration for managing Azure Blob Storage using Infrastructure as Code (IaC).

The configuration uses Terraform data sources to reference an existing Azure Storage Account and Storage Container. It uses `for_each` to support multiple blob configurations.

This repository is part of a modular Azure infrastructure project for a Loan Management System.

## 🏗️ Architecture

The project separates Azure infrastructure into individual Terraform repositories:

- Resource Group
- Storage Account
- Storage Container
- Blob Storage

The Blob Storage configuration references existing Azure resources rather than creating the Storage Account or Container again.

## ☁️ Azure Configuration

| Property | Value |
|---|---|
| Cloud Provider | Microsoft Azure |
| Infrastructure as Code | Terraform |
| Storage Account | `stlmsidndev001` |
| Container | `loan-documents` |
| Example Blob | `loan-application-sample.pdf` |

*Verify these resource names against your current Terraform configuration.*

## 📂 Repository Structure

```text
terraform-azure-blob/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── provider.tf
├── .gitignore
└── README.md
```

*Adjust the structure if your repository contains different files.*

## ⚙️ Terraform Configuration

### 1. Storage Account Data Source

This data source retrieves information about an existing Azure Storage Account.

```hcl
data "azurerm_storage_account" "storage_account" {
  for_each = var.blobs

  name                = each.value.storage_account_name
  resource_group_name = each.value.resource_group_name
}
```

**Purpose:**
- References an existing Storage Account.
- Uses `for_each` to process the blob configuration map.
- Retrieves the Storage Account ID for the related container lookup.

### 2. Storage Container Data Source

This data source retrieves an existing Azure Storage Container using the corresponding Storage Account ID.

```hcl
data "azurerm_storage_container" "container" {
  for_each = var.blobs

  name               = each.value.container_name
  storage_account_id = data.azurerm_storage_account.storage_account[each.key].id
}
```

**Purpose:**
- References an existing container.
- Uses `each.key` to match the corresponding Storage Account.
- Avoids creating a duplicate container.

### 3. Blob Management

The data sources above look up existing Azure resources. The blob resource configuration is responsible for managing or uploading the blob.

The exact blob resource arguments depend on the `azurerm_storage_blob` configuration in `main.tf`.

## 🔄 How It Works

1. Terraform reads the configuration from `var.blobs`.
2. The Storage Account data source looks up the existing account.
3. The Storage Container data source looks up the matching container.
4. The blob resource uses the relevant storage details to manage the file.
5. Terraform compares the configuration with its state and plans the required changes.

## 🚀 Deployment Steps

### Step 1: Login to Azure

```powershell
az login
```

### Step 2: Initialize Terraform

```powershell
terraform init
```

### Step 3: Validate Configuration

```powershell
terraform validate
```

### Step 4: Review the Execution Plan

```powershell
terraform plan
```

### Step 5: Apply Configuration

```powershell
terraform apply
```

Review the proposed changes and approve the plan when prompted.

## 🔍 Verify in Azure Portal

1. Open the Azure Portal.
2. Navigate to **Storage accounts**.
3. Open the configured Storage Account.
4. Select **Data storage → Containers**.
5. Open the configured container.
6. Verify that the expected blob is present.

## 🔐 Best Practices

- Use data sources to reference existing Azure resources.
- Use `for_each` for reusable configuration.
- Keep Storage Account and container names consistent with the variable map.
- Never commit credentials or secrets to GitHub.
- Review `terraform plan` before applying changes.
- Use appropriate Azure permissions.
- Configure a remote backend when shared Terraform state is required.

## 🎯 Key Learnings

- Azure Blob Storage management using Terraform.
- Referencing existing Storage Accounts and Containers through data sources.
- Using `for_each` with a map variable.
- Connecting Terraform resources through resource IDs.
- Organizing Azure infrastructure into separate repositories.

## 👩‍💻 Author

**Sharanjeet Kaur**

Azure | Terraform | Azure DevOps | Infrastructure as Code

## 🏷️ Tags

`Azure` `Terraform` `Blob Storage` `Data Sources` `for_each` `IaC` `DevOps` `Automation`
