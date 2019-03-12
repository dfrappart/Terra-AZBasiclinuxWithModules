#Creating Storage Account for files exchange

#Creating Log storage account

module "FileStorageAccount" {

    #Module location
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//03 StorageAccountGP"

    #Module variable
    StorageAccountName          = "${var.EnvironmentTag}file"
    RGName                      = "${module.ResourceGroup.Name}"
    StorageAccountLocation      = "${var.AzureRegion}"
    StorageAccountTier          = "${lookup(var.storageaccounttier, 0)}"
    StorageReplicationType      = "${lookup(var.storagereplicationtype, 0)}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"
    OwnerTag                    = "${var.OwnerTag}"
    ProvisioningDateTag         = "${var.ProvisioningDateTag}"
}

#Creating Storage Share

module "InfraFileShare" {
  #Module location
  #source = "./Modules/05 StorageAccountShare"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//05 StorageAccountShare"

  #Module variable
  ShareName          = "infrafileshare"
  RGName             = "${module.ResourceGroup.Name}"
  StorageAccountName = "${module.FileStorageAccount.Name}"
  Quota              = "5120"
}
