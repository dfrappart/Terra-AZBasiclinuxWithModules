######################################################
# This file defines which value are sent to output
######################################################

######################################################
# Resource group info Output

output "ResourceGroupName" {
  value = "${module.ResourceGroup.Name}"
}

output "ResourceGroupId" {
  value = "${module.ResourceGroup.Id}"
}

######################################################
# vNet info Output

output "vNetName" {
  value = "${module.SampleArchi_vNet.Name}"
}

output "vNetId" {
  value = "${module.SampleArchi_vNet.Id}"
}

output "vNetAddressSpace" {
  value = "${module.SampleArchi_vNet.AddressSpace}"
}

######################################################
# Log&Diag Storage account Info

output "DiagStorageAccountName" {
  value = "${module.DiagStorageAccount.Name}"
}

output "DiagStorageAccountID" {
  value = "${module.DiagStorageAccount.Id}"
}

output "DiagStorageAccountPrimaryBlobEP" {
  value = "${module.DiagStorageAccount.PrimaryBlobEP}"
}

output "DiagStorageAccountPrimaryQueueEP" {
  value = "${module.DiagStorageAccount.PrimaryQueueEP}"
}

output "DiagStorageAccountPrimaryTableEP" {
  value = "${module.DiagStorageAccount.PrimaryTableEP}"
}

output "DiagStorageAccountPrimaryFileEP" {
  value = "${module.DiagStorageAccount.PrimaryFileEP}"
}

output "DiagStorageAccountPrimaryAccessKey" {
  value = "${module.DiagStorageAccount.PrimaryAccessKey}"
}

output "DiagStorageAccountSecondaryAccessKey" {
  value = "${module.DiagStorageAccount.SecondaryAccessKey}"
}

######################################################
# Files Storage account Info

output "FileStorageAccountName" {
  value = "${module.FileStorageAccount.Name}"
}

output "FileStorageAccountID" {
  value = "${module.FileStorageAccount.Id}"
}

output "FileStorageAccountPrimaryBlobEP" {
  value = "${module.FileStorageAccount.PrimaryBlobEP}"
}

output "FileStorageAccountPrimaryQueueEP" {
  value = "${module.FileStorageAccount.PrimaryQueueEP}"
}

output "FileStorageAccountPrimaryTableEP" {
  value = "${module.FileStorageAccount.PrimaryTableEP}"
}

output "FileStorageAccountPrimaryFileEP" {
  value = "${module.FileStorageAccount.PrimaryFileEP}"
}

output "FileStorageAccountPrimaryAccessKey" {
  value = "${module.FileStorageAccount.PrimaryAccessKey}"
}

output "FileStorageAccountSecondaryAccessKey" {
  value = "${module.FileStorageAccount.SecondaryAccessKey}"
}

######################################################
# Subnet info Output
######################################################

######################################################
#FE_Subnet

output "FE_Subnet" {
  value = "${module.FE_Subnet.Name}"
}

output "FE_SubnetId" {
  value = "${module.FE_Subnet.Id}"
}

output "FE_SubnetAddressPrefix" {
  value = "${module.FE_Subnet.AddressPrefix}"
}

######################################################
#BE_Subnet

output "BE_SubnetName" {
  value = "${module.BE_Subnet.Name}"
}

output "BE_SubnetId" {
  value = "${module.BE_Subnet.Id}"
}

output "BE_SubnetAddressPrefix" {
  value = "${module.BE_Subnet.AddressPrefix}"
}

######################################################
#Bastion_Subnet

output "Bastion_SubnetName" {
  value = "${module.Bastion_Subnet.Name}"
}

output "Bastion_SubnetId" {
  value = "${module.Bastion_Subnet.Id}"
}

output "Bastion_SubnetAddressPrefix" {
  value = "${module.Bastion_Subnet.AddressPrefix}"
}



