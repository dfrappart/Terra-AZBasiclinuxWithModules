######################################################
# This file deploy the subnet and NSG for 
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
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//07 NSG/"

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
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 0)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 0)}"
    NSGid                       = "${module.NSG_FE_Subnet.Id}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"

}


######################################################################
# Back End
######################################################################

#BE_Subnet NSG

module "NSG_BE_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//07 NSG/"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 1)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#BE_Subnet

module "BE_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 Subnet"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 1)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 1)}"
    NSGid                       = "${module.NSG_BE_Subnet.Id}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"

}

######################################################################
# Infra zone
######################################################################


#Infra_Subnet NSG


module "NSG_Bastion_Subnet" {

    #Module location
    #source = "./Modules/07 NSG"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//07 NSG/"

    #Module variable
    NSGName                 = "NSG_${lookup(var.SubnetName, 2)}"
    RGName                  = "${module.ResourceGroup.Name}"
    NSGLocation             = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}

#Bastion_Subnet

module "Bastion_Subnet" {

    #Module location
    #source = "./Modules/06 Subnet"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 Subnet/"

    #Module variable
    SubnetName                  = "${lookup(var.SubnetName, 2)}"
    RGName                      = "${module.ResourceGroup.Name}"
    vNetName                    = "${module.SampleArchi_vNet.Name}"
    Subnetaddressprefix         = "${lookup(var.SubnetAddressRange, 2)}"
    NSGid                       = "${module.NSG_Bastion_Subnet.Id}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"

}
