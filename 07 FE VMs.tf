##############################################################
#This file creates FE Web servers
##############################################################

#Creating ASGs

module "FEASG" {
    #Module Source
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07-2 Application Security Group"

    #Module variables
    ASGName             = "FEASG"
    RGName              = "${module.ResourceGroup.Name}"
    ASGLocation         = "${var.AzureRegion}"
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
    OwnerTag            = "${var.OwnerTag}"
    ProvisioningDateTag = "${var.ProvisioningDateTag}"
}

#NSG rules for FE servers

module "AllowHTTPFromInternetFEIn" {
  #Module source
  #source = "./Modules/08-2 NSGRule with services tags"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//08-3 NSGRule with Dest ASG"

  #Module variable
  RGName                          = "${module.ResourceGroup.Name}"
  NSGReference                    = "${module.NSG_FE_Subnet.Name}"
  NSGRuleName                     = "AllowHTTPFromInternetFEIn"
  NSGRulePriority                 = 101
  NSGRuleDirection                = "Inbound"
  NSGRuleAccess                   = "Allow"
  NSGRuleProtocol                 = "Tcp"
  NSGRuleSourcePortRange          = "*"
  NSGRuleDestinationPortRange     = 80
  NSGRuleSourceAddressPrefix      = "Internet"
  NSGRuleDestinationASG           = "${module.FEASG.Id}"
}



#NIC Creation

module "NICs_FEWEB" {
  #module source

  #source = "./Modules/09 NICWithoutPIPWithCount"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//09 NICWithoutPIPWithCount"

  #Module variables

  NICcount            = "3"
  NICName             = "NIC_FEWEB"
  NICLocation         = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  SubnetId            = "${module.FE_Subnet.Id}"
  IsLoadBalanced      = "1"
  LBBackEndPoolid     = ["${module.LBWebFE.LBBackendPoolIds}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#Datadisk creation



#VM creation

module "VMs_FEWEB" {
  #module source

  #source = "./Modules/14 LinuxVMWithCount"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//14 - 4 LinuxVMWithCountwithCustomDatawithAZ"

  #Module variables

  VMCount                 = "3"
  VMName                  = "WEB-FE"
  VMLocation              = "${var.AzureRegion}"
  VMRG                    = "${module.ResourceGroup.Name}"
  VMNICid                 = ["${module.NICs_FEWEB.LBIds}"]
  VMSize                  = "${lookup(var.VMSize, 0)}"
  VMStorageTier           = "${lookup(var.Manageddiskstoragetier, 0)}"
  VMAdminName             = "${var.VMAdminName}"
  VMAdminPassword         = "${var.VMAdminPassword}"
  VMPublisherName         = "${lookup(var.PublisherName, 2)}"
  VMOffer                 = "${lookup(var.Offer, 2)}"
  VMsku                   = "${lookup(var.sku, 2)}"
  DiagnosticDiskURI       = "${module.DiagStorageAccount.PrimaryBlobEP}"
  CloudinitscriptPath     = "./Scripts/installnginx.sh"
  PublicSSHKey            = "${var.AzurePublicSSHKey}"
  EnvironmentTag          = "${var.EnvironmentTag}"
  EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
}

#VM Agent



#Network Watcher Agent

module "NetworkWatcherAgentForFEWeb" {
  #Module Location
  #source = "./Modules/20 LinuxNetworkWatcherAgent"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//20 LinuxNetworkWatcherAgent"

  #Module variables
  AgentCount          = "3"
  AgentName           = "NetworkWatcherAgentForFEWeb"
  AgentLocation       = "${var.AzureRegion}"
  AgentRG             = "${module.ResourceGroup.Name}"
  VMName              = ["${module.VMs_FEWEB.Name}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}
