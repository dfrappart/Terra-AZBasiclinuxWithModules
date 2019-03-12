######################################################################
# Ressource Group
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