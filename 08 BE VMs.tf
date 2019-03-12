######################################################################
# BE Apps Servers
######################################################################

######################################################################
# BE Servers
######################################################################

#Creating BE Servers host Application Security Group


#Creating ASGs

module "BEASG" {
    #Module Source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07-2 Application Security Group"

    #Module variables
    ASGName             = "BEASG"
    RGName              = "${module.ResourceGroup.Name}"
    ASGLocation         = "${var.AzureRegion}"
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
    OwnerTag            = "${var.OwnerTag}"
    ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

#Creating Bastion NIC

module "BE_NIC" {
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//12-5 NICwithoutPIPwithCountwithASG"

  #Module variables
  NICcount            = "2"
  NICName             = "BE_NIC"
  NICLocation         = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  SubnetId            = "${module.BE_Subnet.Id}"
  ASGIds              = ["${module.BEASG.Id}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

#Creating BE VMs



module "BEVMs" {
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//14 - 4 LinuxVMWithCountwithCustomDatawithAZ"

  #Module variables
  VMName              = "BEVMs"
  VMLocation          = "${var.AzureRegion}"
  VMRG                = "${module.ResourceGroup.Name}"
  VMNICid             = ["${module.BE_NIC.Ids}"]
  VMAdminPassword     = "${var.VMAdminPassword}"
  VMPublisherName     = "${lookup(var.PublisherName, 2)}"
  VMOffer             = "${lookup(var.Offer, 2)}"
  VMsku               = "${lookup(var.sku, 2)}"
  VMSize              = "Standard_B2ms"
  DiagnosticDiskURI   = "${module.DiagStorageAccount.PrimaryBlobEP}"
  CloudinitscriptPath = "./Scripts/installmariadb.sh"
  PublicSSHKey        = "${var.AzurePublicSSHKey}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

module "NetworkWatcherAgentForBE" {
  #Module Location
  #source = "./Modules/20 LinuxNetworkWatcherAgent"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//20 LinuxNetworkWatcherAgent"

  #Module variables
  AgentCount          = "2"
  AgentName           = "NetworkWatcherAgentForBE"
  AgentLocation       = "${var.AzureRegion}"
  AgentRG             = "${module.ResourceGroup.Name}"
  VMName              = ["${module.BastionVM.Name}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}