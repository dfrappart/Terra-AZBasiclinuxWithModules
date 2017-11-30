###################################################################################
#This module allow the creation of VMAccess Agent for linux
###################################################################################

#Variable declaration for Module


variable "AgentCount" {
  type    = "string"

}

variable "AgentName" {
  type    = "string"

}

variable "AgentLocation" {
  type    = "string"

}

variable "AgentRG" {
  type    = "string"

}

variable "VMName" {
  type    = "list"

}

variable "EnvironmentTag" {
  type    = "string"

}

variable "EnvironmentUsageTag" {
  type    = "string"

}

resource "azurerm_virtual_machine_extension" "Terra-CustomScriptLinuxAgent" {
  

  count                = "${var.AgentCount}"
  name                 = "${var.AgentName}${count.index+1}"
  location             = "${var.AgentLocation}"
  resource_group_name  = "${var.AgentRG}"
  virtual_machine_name = "${element(var.VMName,count.index)}"
  publisher            = "Microsoft.OSTCExtensions"
  type                 = "VMAccessForLinux"
  type_handler_version = "1.4"

      settings = <<SETTINGS
        {   
        "commandToExecute": ""
        }
SETTINGS
    
  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}