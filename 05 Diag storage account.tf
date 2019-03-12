######################################################################
# Diag Storage Account
######################################################################


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

