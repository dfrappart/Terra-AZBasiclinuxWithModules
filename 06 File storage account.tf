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
  Quota              = "5120"
}
