######################################################
# This file deploys the base AZure Resource
# Resource Group + vNet
######################################################

######################################################################
# Access to Azure
######################################################################

# Configure the Microsoft Azure Provider with Azure provider variable defined in AzureDFProvider.tf

provider "azurerm" {
  subscription_id = "${var.AzureSubscriptionID1}"
  client_id       = "${var.AzureClientID}"
  client_secret   = "${var.AzureClientSecret}"
  tenant_id       = "${var.AzureTenantID}"
}

######################################################################
# Foundations resources, including ResourceGroup and vNET
######################################################################

# Creating the ResourceGroup

module "ResourceGroup" {
  #Module Location
  #source = "./Modules/01 ResourceGroup"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//01 ResourceGroup/"

  #Module variable
  RGName              = "${var.RGName}"
  RGLocation          = "${var.AzureRegion}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

# Creating vNET

module "SampleArchi_vNet" {
  #Module location
  #source = "./Modules/02 vNet"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//02 vNet/"

  #Module variable
  vNetName            = "SampleArchi_vNet"
  RGName              = "${module.ResourceGroup.Name}"
  vNetLocation        = "${var.AzureRegion}"
  vNetAddressSpace    = "${var.vNetIPRange}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#Creating Storage Account for logs and Diagnostics

module "DiagStorageAccount" {
  #Module location
  #source = "./Modules/03 StorageAccountGP"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//03 StorageAccountGP/"

  #Module variable
  StorageAccountName     = "diaglog2"
  RGName                 = "${module.ResourceGroup.Name}"
  StorageAccountLocation = "${var.AzureRegion}"
  StorageAccountTier     = "${lookup(var.storageaccounttier, 0)}"
  StorageReplicationType = "${lookup(var.storagereplicationtype, 0)}"
  EnvironmentTag         = "${var.EnvironmentTag}"
  EnvironmentUsageTag    = "${var.EnvironmentUsageTag}"
}

module "LogStorageContainer" {
  #Module location
  #source = "./Modules/04 StorageAccountContainer"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//04 StorageAccountContainer/"

  #Module variable
  StorageContainerName = "logs"
  RGName               = "${module.ResourceGroup.Name}"
  StorageAccountName   = "${module.DiagStorageAccount.Name}"
  AccessType           = "private"
}

#Creating Storage Account for files exchange

module "FilesExchangeStorageAccount" {
  #Module location
  #source = "./Modules/03 StorageAccountGP"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//03 StorageAccountGP/"

  #Module variable
  StorageAccountName     = "file2"
  RGName                 = "${module.ResourceGroup.Name}"
  StorageAccountLocation = "${var.AzureRegion}"
  StorageAccountTier     = "${lookup(var.storageaccounttier, 0)}"
  StorageReplicationType = "${lookup(var.storagereplicationtype, 0)}"
  EnvironmentTag         = "${var.EnvironmentTag}"
  EnvironmentUsageTag    = "${var.EnvironmentUsageTag}"
}

#Creating Storage Share

module "InfraFileShare" {
  #Module location
  #source = "./Modules/05 StorageAccountShare"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//05 StorageAccountShare"

  #Module variable
  ShareName          = "infrafileshare"
  RGName             = "${module.ResourceGroup.Name}"
  StorageAccountName = "${module.FilesExchangeStorageAccount.Name}"
  Quota              = "0"
}
