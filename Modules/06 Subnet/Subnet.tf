##############################################################
#This module allow the creation of a Netsork Security Group
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


    name                        = "${var.SubnetName}"
    resource_group_name         = "${var.RGName}"
    virtual_network_name        = "${var.vNetName}"
    address_prefix              = "${var.Subnetaddressprefix}"
    network_security_group_id   = "${var.NSGid}"


}

#Output

output "Name" {

  value = "${azurerm_subnet.TerraSubnet.name}"
}

output "Id" {

  value = "${azurerm_subnet.TerraSubnet.id}"
}

output "AddressPrefix" {

  value = "${azurerm_subnet.TerraSubnet.address_prefix}"
}