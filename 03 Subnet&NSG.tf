######################################################
# This file deploys the subnet and NSG for 
#Basic linux architecture Architecture
######################################################

######################################################################
# Subnet and NSG
######################################################################

######################################################################
# Front End
######################################################################

#FE_Subnet NSG

module "NSG_FE_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 0)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#FE-PRD_Subnet

module "FE_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-1 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 0)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 0)}"
    NSGid                       = "${module.NSG_FE_Subnet.Id}"


}


######################################################################
# Apps subnet
######################################################################

#App_Subnet NSG

module "NSG_App_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
  source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 1)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#App_Subnet

module "App_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-1 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 1)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 1)}"
    NSGid                       = "${module.NSG_App_Subnet.Id}"


}


######################################################################
# Back End
######################################################################

#BE_Subnet NSG

module "NSG_BE_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 2)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#BE_Subnet

module "BE_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-1 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 2)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 2)}"
    NSGid                       = "${module.NSG_BE_Subnet.Id}"


}

######################################################################
# Bastion zone
######################################################################


#Bastion NSG


module "NSG_Bastion_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 7)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#Bastion_Subnet

module "Bastion_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-1 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 7)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 7)}"
    NSGid                       = "${module.NSG_Bastion_Subnet.Id}"


}


######################################################################
# AppGW_Subnet
######################################################################


#AppGW_Subnet NSG


module "NSG_AppGW_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 4)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#Bastion_Subnet

module "AppGW_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-1 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 4)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 4)}"
    NSGid                       = "${module.NSG_AppGW_Subnet.Id}"


}

######################################################################
# GatewaySubnet
######################################################################

#Bastion_Subnet

module "GatewaySubnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-2 SubnetWithoutNSG"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 3)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 3)}"

}




######################################################################
# AzureFirewallSubnet
######################################################################

#Bastion_Subnet

module "AzureFirewallSubnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-2 SubnetWithoutNSG"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 5)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 5)}"

}

######################################################################
# ShareSVC_Subnet
######################################################################


#ShareSVC_Subnet NSG


module "NSG_ShareSVC_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//07 NSG"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 6)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#Bastion_Subnet

module "ShareSVC_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZModuletest//Modules//06-1 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 6)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 6)}"
    NSGid                       = "${module.NSG_ShareSVC_Subnet.Id}"


}