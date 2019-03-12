######################################################################
# VNet
######################################################################

# Creating vNET

module "SampleArchi_vNet" {
  #Module location
  #source = "./Modules/02 vNet"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//02 vNet/"

  #Module variable
  vNetName            = "VNet_${var.EnvironmentTag}"
  RGName              = "${module.ResourceGroup.Name}"
  vNetLocation        = "${var.AzureRegion}"
  vNetAddressSpace    = "${var.vNetIPRange}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}