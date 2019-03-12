##############################################################
#This file creates Bastion servers
##############################################################

#Creating ASGs

module "BastionASG" {
    #Module Source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07-2 Application Security Group"

    #Module variables
    ASGName             = "Bastion"
    RGName              = "${module.ResourceGroup.Name}"
    ASGLocation         = "${var.AzureRegion}"
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
    OwnerTag            = "${var.OwnerTag}"
    ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

#Creating Bastion related NSG rules

module "AllowSSHFromInternetToBastiontoIn" {
  #Module Source
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//08-3 NSGRule with Dest ASG"

  #Module variables
  NSGRuleName                   = "AllowSSHFromInternetToBastiontoIn"
  NSGRulePriority               = "1001"
  NSGRuleDirection              = "inbound"
  NSGRuleAccess                 = "allow"
  NSGRuleProtocol               = "Tcp"
  NSGRuleSourcePortRange        = "*"
  NSGRuleDestinationPortRange   = "22"
  NSGRuleSourceAddressPrefix    = "Internet"
  NSGRuleDestinationASG         = ["${module.BastionASG.Id}"]
  RGName                        = "${module.ResourceGroup.Name}"
  NSGReference                  = "${module.NSG_Bastion_Subnet.Name}"
}


module "AllowRDPFromInternetToBastiontoIn" {
  #Module Source
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//08-3 NSGRule with Dest ASG"

  #Module variables
  NSGRuleName                   = "AllowRDPFromInternetToBastiontoIn"
  NSGRulePriority               = "1002"
  NSGRuleDirection              = "inbound"
  NSGRuleAccess                 = "allow"
  NSGRuleProtocol               = "Tcp"
  NSGRuleSourcePortRange        = "*"
  NSGRuleDestinationPortRange   = "3389"
  NSGRuleSourceAddressPrefix    = "Internet"
  NSGRuleDestinationASG         = ["${module.BastionASG.Id}"]
  RGName                        = "${module.ResourceGroup.Name}"
  NSGReference                  = "${module.NSG_Bastion_Subnet.Name}"
}


#Creating Bastion Pip

module "BastionPIP" {
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//10 PublicIP"

  #Module variables
  PublicIPName        = "bastionpip"
  PublicIPLocation    = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  IsZoneRedundant     = "true"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

#Creating Bastion NIC

module "BastionNIC" {
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//12-6 NICwithPIPwithCountwithASG"

  #Module variables
  NICName             = "BastionNIC"
  NICLocation         = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  SubnetId            = "${module.Bastion_Subnet.Id}"
  PublicIPId          = "${module.BastionPIP.ZRIPIds}"
  ASGIds              = ["${module.BastionASG.Id}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

#Creating Bastion VM

module "BastionVM" {
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//14 - 4 LinuxVMWithCountwithCustomDatawithAZ"

  #Module variables
  VMName              = "BastionVM"
  VMLocation          = "${var.AzureRegion}"
  VMRG                = "${module.ResourceGroup.Name}"
  VMNICid             = ["${module.BastionNIC.Ids}"]
  VMAdminPassword     = "${var.VMAdminPassword}"
  VMPublisherName     = "${lookup(var.PublisherName, 2)}"
  VMOffer             = "${lookup(var.Offer, 2)}"
  VMsku               = "${lookup(var.sku, 2)}"
  VMSize              = "Standard_B2ms"
  DiagnosticDiskURI   = "${module.DiagStorageAccount.PrimaryBlobEP}"
  #CloudinitscriptPath = "./Scripts/installansible.sh"
  PublicSSHKey        = "${var.AzurePublicSSHKey}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

/*


#Creating Bastion VM

module "BastionVM" {
  #Module location
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//14 - 3 LinuxVMWithCountwithAZ"

  #Module variables
  VMName              = "BastionVM"
  VMLocation          = "${var.AzureRegion}"
  VMRG                = "${module.ResourceGroup.Name}"
  VMNICid             = ["${module.BastionNIC.Ids}"]
  VMAdminPassword     = "${var.VMAdminPassword}"
  VMPublisherName     = "${lookup(var.PublisherName, 2)}"
  VMOffer             = "${lookup(var.Offer, 2)}"
  VMsku               = "${lookup(var.sku, 2)}"
  VMSize              = "Standard_B2ms"
  DiagnosticDiskURI   = "${module.DiagStorageAccount.PrimaryBlobEP}"
  PublicSSHKey        = "${var.AzurePublicSSHKey}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  OwnerTag            = "${var.OwnerTag}"
  ProvisioningDateTag = "${var.ProvisioningDateTag}"
}


*/
module "NetworkWatcherAgentForBastion" {
  #Module Location
  #source = "./Modules/20 LinuxNetworkWatcherAgent"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//20 LinuxNetworkWatcherAgent"

  #Module variables
  AgentName           = "NetworkWatcherAgentForBastion"
  AgentLocation       = "${var.AzureRegion}"
  AgentRG             = "${module.ResourceGroup.Name}"
  VMName              = ["${module.BastionVM.Name}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}
