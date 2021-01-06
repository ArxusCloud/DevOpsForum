# DevOpsForum

![Deploy ASP.NET Core app to Azure Web App](https://github.com/ArxusCloud/DevOpsForum/workflows/Deploy%20ASP.NET%20Core%20app%20to%20Azure%20Web%20App/badge.svg)


Create Storage Account For Terraform State
``` bash
az group create -g rg-devopsforum-tf -l westeurope

az storage account create -n sadevopsforumtf -g rg-devopsforum-tf -l westeurope --sku Standard_LRS

az storage container create -n terraform-state --account-name sadevopsforumtf

```
