# A lot of values in the below module block will need to be obtained from Platform Engineering. This is to ensure the servers being built have been requested by the correct infrastructure teams and spec'd accordingly.
# Once all the information needed is obtained replace any placehoders < > with the real values
module "testvm" {

  source                = "terraform.caresource.corp/caresource/virtualmachine-rhel/vsphere" ## Module source location  in Private Module Registry
  version               = "0.3.3" ## Latest module version found here: https://terraform.caresource.corp/app/caresource/registry/private/modules
  vm_size               = "small" ## Size of VM being requested: "Small, Medium, Large"
  datacenter            = "DAY" ## Datacenter the VM will be created: "DAY"
  environment           = "DEV" ## App environment for the server: "DEV, INT, CRT"
  app_name              = "cfdemo" ## 3 letter app abbreviation
  server_number         = 1 ## Number of servers you want created 
  vsphere_cluster       = "DAYCRTHXCLST10" ## Vsphere cluster name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datacenter    = "DAY_CRT_HX" ## Vsphere datacenter name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datastore     = "DAYCRTHXCLST10_OS_02" ## Vsphere datastore name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_resource_pool = "DAYCRTHXCLST10/Resources" ## Vsphere resource pool name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_tag_category  = "Auto_Group" ## Tags group to be applied in vsphere
  vsphere_tag_name      = ["NeedToInventory", "Manual"] ## Tag names to be applied
  vsphere_folder        = "Test" ## Vsphere folder the server will be built in: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  network_cidr          = "10.121.132.0/22" ## Network CIDR that will be used to reserver an IP address for the server: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_network       = "239_APP_VRA" ## Vsphere network name the server will be assigned to: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  centadmin_p           = data.thycotic_secret.centadmin_p.password
  ticket_number         = "INC0000000" ## Ticket number for tracking

}

output "vm_testvm_ipaddress" {
  value = module.testvm.ip_address
}

output "vm_testvm_fqdn" {
  value = module.testvm.fqdn
}

output "testvm_tags" {
  value = module.testvm.*.tags
}
