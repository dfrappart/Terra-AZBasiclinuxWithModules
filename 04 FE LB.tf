######################################################################
# Internet facing Load Balancer
######################################################################


#Azure Load Balancer public IP Creation

module "LBWebPublicIP" {
  #Module source
  #source = "./Modules/10 PublicIP"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//10 PublicIP"

  #Module variables
  PublicIPCount       = "1"
  PublicIPName        = "lbwebpip"
  PublicIPLocation    = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

module "LBWebFE" {
  #Module source
  #source = "./Modules/15 External LB"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//18 External LB"

  #Module variables
  LBCount           = "1"
  ExtLBName         = "LBWebFE"
  AzureRegion       = "${var.AzureRegion}"
  RGName            = "${module.ResourceGroup.Name}"
  FEConfigName      = "LBWebFEConfig"
  PublicIPId        = ["${module.LBWebPublicIP.Ids}"]
  LBBackEndPoolName = "LBWebFE_BEPool"
  LBProbeName       = "LBWebFE_Probe"
  LBProbePort       = "80"
  FERuleName        = "LBWebFEHTTPRule"
  FERuleProtocol    = "tcp"
  FERuleFEPort      = "80"
  FERuleBEPort      = "80"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}