##############################################################
#This module allows the creation of a Netsork Security Group
##############################################################

#Variable declaration for Module

variable "SubnetName" {
  type    = "string"
  default = "DefaultSubnet"
}


variable "RGName" {
  type    = "string"
  default = "DefaultRSG"
}

variable "vNetName" {
  type    = "string"

}

variable "Subnetaddressprefix" {
  type    = "string"

}

variable "NSGid" {
  type    = "string"
  default = "default"

}

variable "SubnetisGW" {
  type    = "string"
  default = "0"

}

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}

#Creation fo the subnet

resource "azurerm_subnet" "TerraSubnet" {

#Use conditional to select if the Subnet is a Gateway subnet and should have a NSG
#If SubnetisGW exist, count is set to 0 for this resource which is a subnet with NSG
    count                       = "${var.SubnetisGW ? 0 : 1}"
    name                        = "${var.SubnetName}"
    resource_group_name         = "${var.RGName}"
    virtual_network_name        = "${var.vNetName}"
    address_prefix              = "${var.Subnetaddressprefix}"
    network_security_group_id   = "${var.NSGid}"


}


resource "azurerm_subnet" "TerraSubnetGW" {

#Use conditional to select if the Subnet is a Gateway subnet and should have a NSG
#If SubnetisGW exist, count is set to 1 for this resource which is a subnet without NSG
    count                       = "${var.SubnetisGW ? 1 : 0}"
    name                        = "${var.SubnetName}"
    resource_group_name         = "${var.RGName}"
    virtual_network_name        = "${var.vNetName}"
    address_prefix              = "${var.Subnetaddressprefix}"
    #network_security_group_id   = "${var.NSGid}"


}

#Output



output "Name" {

  value = "${var.SubnetisGW == "0" ? azurerm_subnet.TerraSubnet.name[0] : azurerm_subnet.TerraSubnetGW.name[0]}"
}

output "Id" {

  value = "${var.SubnetisGW == "0"? azurerm_subnet.TerraSubnet.id[0] : azurerm_subnet.TerraSubnetGW.id[0]}"
}

output "AddressPrefix" {

  value = "${var.SubnetisGW == "0" ? azurerm_subnet.TerraSubnet.address_prefix[0] : azurerm_subnet.TerraSubnetGW.address_prefix[0]}"
}