###################################################################################
#This module allows the creation of n CustomLinuxExtension and install nginx
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
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

      settings = <<SETTINGS
        {   
        
        "fileUris": [ "https://raw.githubusercontent.com/dfrappart/Terra-AZBasiclinuxWithModules/master/Scripts/installnginx.sh" ],
        "commandToExecute": "bash installnginx.sh"
        }
SETTINGS
    
  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}