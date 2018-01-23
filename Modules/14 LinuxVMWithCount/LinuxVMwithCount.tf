###################################################################################
#This module allows the creation of n Linux VM with 1 NIC
###################################################################################

#Variable declaration for Module

#The VM count
variable "VMCount" {
  type    = "string"

}

#The VM name
variable "VMName" {
  type    = "string"

}


#The VM location
variable "VMLocation" {
  type    = "string"

}

#The RG in which the VMs are located
variable "VMRG" {
  type    = "string"

}

#The NIC to associate to the VM
variable "VMNICid" {
  type    = "list"

}

#The VM size
variable "VMSize" {
  type    = "string"
  default = "Standard_F1"

}


#The Availability set reference

variable "ASID" {
  type    = "string"
  
}

#The Managed Disk Storage tier

variable "VMStorageTier" {
  type    = "string"
  default = "Premium_LRS"
  
}

#The VM Admin Name

variable "VMAdminName" {
  type    = "string"
  default = "VMAdmin"
  
}

#The VM Admin Password

variable "VMAdminPassword" {
  type    = "string"
  
}

# Managed Data Disk reference

variable "DataDiskId" {
  type    = "list"

  
}

# Managed Data Disk Name

variable "DataDiskName" {
  type    = "list"

  
}

# Managed Data Disk size

variable "DataDiskSize" {
  type    = "list"
  
}

# VM images info
#get appropriate image info with the following command
#Get-AzureRMVMImagePublisher -location WestEurope
#Get-AzureRMVMImageOffer -location WestEurope -PublisherName <PublisherName>
#Get-AzureRmVMImageSku -Location westeurope -Offer <OfferName> -PublisherName <PublisherName>

variable "VMPublisherName" {
  type    = "string"
  
}


variable "VMOffer" {
  type    = "string"
  
}

variable "VMsku" {
  type    = "string"
  
}

#The boot diagnostic storage uri

variable "DiagnosticDiskURI" {
  type    = "string"
  
}

#The boot config file name

variable "BootConfigScriptFileName" {

  type    = "string"

}


variable "PublicSSHKey" {

  type = "string"
}

#Tag info

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}



#VM Creation


resource "azurerm_virtual_machine" "TerraVMwithCount" {

    count                   = "${var.VMCount}"
    name                    = "${var.VMName}${count.index+1}"
    location                = "${var.VMLocation}"
    resource_group_name     = "${var.VMRG}"
    network_interface_ids   = ["${element(var.VMNICid, count.index)}"]
    vm_size                 = "${var.VMSize}"
    availability_set_id     = "${var.ASID}"
    
    boot_diagnostics {

      enabled = "true"
      storage_uri = "${var.DiagnosticDiskURI}"

    }


    storage_image_reference {
        #get appropriate image info with the following command
        #Get-AzureRmVMImageSku -Location westeurope -Offer windowsserver -PublisherName microsoftwindowsserver
        publisher   = "${var.VMPublisherName}"
        offer       = "${var.VMOffer}"
        sku         = "${var.VMsku}"
        version     = "latest"

    }

    storage_os_disk {

        name                = "${var.VMName}${count.index+1}-OSDisk"
        caching             = "ReadWrite"
        create_option       = "FromImage"
        managed_disk_type   = "${var.VMStorageTier}"

    }

    storage_data_disk {

        name                = "${element(var.DataDiskName,count.index)}"
        managed_disk_id     = "${element(var.DataDiskId,count.index)}"
        create_option       = "Attach"
        lun                 = 0
        disk_size_gb        = "${element(var.DataDiskSize,count.index)}"
        

    }

    os_profile {

        computer_name   = "${var.VMName}"
        admin_username  = "${var.VMAdminName}"
        admin_password  = "${var.VMAdminPassword}"
        custom_data     = "${file("${var.BootConfigScriptFileName}")}"

    }

    os_profile_linux_config {
    
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.VMAdminName}/.ssh/authorized_keys"
      key_data = "${var.PublicSSHKey}"
    }

    }
    tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
    }   
    

}

/*
#Adding customscript extension for Linux

resource "azurerm_virtual_machine_extension" "Terra-CustomScriptLinuxAgent" {
  

  count                = "${var.VMCount}"
  name                 = "${var.VMName}${count.index+1}CustomScript"
  location             = "${var.VMLocation}"
  resource_group_name  = "${var.VMRG}"
  virtual_machine_name = "${element(azurerm_virtual_machine.TerraVMwithCount.*.name,count.index)}"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

      settings = <<SETTINGS
        {   
        
        "commandToExecute": "sudo yum install vim -y"
        }
SETTINGS
    
  tags {
    environment = "${var.EnvironmentTag}"
    usage       = "${var.EnvironmentUsageTag}"
  }
}

*/
/*
#Adding Networkwatcher agent

resource "azurerm_virtual_machine_extension" "Terra-NetworkWatcherAgent" {
  

  count                = "${var.VMCount}"
  name                 = "${var.VMName}${count.index+1}NetworkWatcherAgent"
  location             = "${var.VMLocation}"
  resource_group_name  = "${var.VMRG}"
  virtual_machine_name = "${element(azurerm_virtual_machine.TerraVMwithCount.*.name,count.index)}"
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
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
*/

/*
#Adding DSC agent

resource "azurerm_virtual_machine_extension" "Terra-DSCAgent" {
  

  count                = "${var.VMCount}"
  name                 = "${var.VMName}${count.index+1}DSCAgent"
  location             = "${var.VMLocation}"
  resource_group_name  = "${var.VMRG}"
  virtual_machine_name = "${element(azurerm_virtual_machine.TerraVMwithCount.*.name,count.index)}"
  publisher            = "microsoft.powershell"
  type                 = "dsc"
  type_handler_version = "2.9"

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
*/

output "Name" {

  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.name}"]
}

output "Id" {

  value = ["${azurerm_virtual_machine.TerraVMwithCount.*.id}"]
}

