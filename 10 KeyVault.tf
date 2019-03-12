#####################################################################
# keyvault Creation
######################################################################



#keyvault creation

module "KeyVault" {

  #Module source
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//27 Keyvault"

  #Module variables
  KeyVaultName            = "${lower(var.EnvironmentTag)}keyvault"
  KeyVaultRG              = "${module.ResourceGroup.Name}"
  KeyVaultObjectIDPolicy2 = "${var.AzureServicePrincipalInteractive}"
  KeyVaultObjectIDPolicy1 = "${var.AzureTFSP}"
  KeyVaultTenantID        = "${var.AzureTenantID}"
  KeyVaultSKUName         = "premium"
  EnvironmentTag          = "${var.EnvironmentTag}"
  EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
  OwnerTag                = "${var.OwnerTag}"
  ProvisioningDateTag     = "${var.ProvisioningDateTag}"
}



module "StoringVMDefaultPWDInVault" {

  #Module source
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//28 KeyvaultSecret"

  #Module variables
  PasswordName            = "DefaultVMPWD"
  PasswordValue           = "${var.VMAdminPassword}"
  KeyVaultId              = "${module.KeyVault.Id}"
  EnvironmentTag          = "${var.EnvironmentTag}"
  EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
  OwnerTag                = "${var.OwnerTag}"
  ProvisioningDateTag     = "${var.ProvisioningDateTag}"

}

module "StoringVMDefaultSSHKeyInVault" {

  #Module source
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//28 KeyvaultSecret"

  #Module variables
  PasswordName            = "DefaultSSHKey"
  PasswordValue           = "${var.AzurePublicSSHKey}"
  KeyVaultId              = "${module.KeyVault.Id}"
  EnvironmentTag          = "${var.EnvironmentTag}"
  EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
  OwnerTag                = "${var.OwnerTag}"
  ProvisioningDateTag     = "${var.ProvisioningDateTag}"

}

