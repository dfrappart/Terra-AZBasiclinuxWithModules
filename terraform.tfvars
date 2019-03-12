######################################################################
# This file references the VM B sizes
######################################################################

RGName                = "RG3TiersApps"
RGBastionName         = "RG_Bastion"

AzureRegion           = "westeurope"
VNet1Name             = "VNet1"
vNetIPRange          = ["10.231.0.0/16"]


SubnetAddressRange = {
    "0" = "10.231.0.0/24"
    "1" = "10.231.1.0/24"
    "2" = "10.231.2.0/24"
    "3" = "10.231.3.0/24"
    "4" = "10.232.3.0/24"
    "5" = "10.233.4.0/24"
    "6" = "10.233.5.0/24"
    "7" = "10.233.6.0/24"

  }

SubnetName = {
    "0" = "FE_Subnet"
    "1" = "App_Subnet"
    "2" = "BE_Subnet"
    "3" = "GatewaySubnet"
    "4" = "AppGW_Subnet"
    "5" = "AzureFirewallSubnet"
    "6" = "ShareSVC_Subnet"
    "7" = "Bastion_Subnet"

  }


EnvironmentTag      = "Demo3Tiers"
EnvironmentUsageTag = "PoC"
OwnerTag            = "DF"
ProvisioningDateTag = "20190315"