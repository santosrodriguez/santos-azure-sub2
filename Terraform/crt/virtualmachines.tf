# A lot of values in the below module block will need to be obtained from Platform Engineering. This is to ensure the servers being built have been requested by the correct infrastructure teams and spec'd accordingly.
# Once all the information needed is obtained replace any placehoders < > with the real values
module "testvm" {

  source                = "terraform.caresource.corp/caresource/virtualmachine-rhel/vsphere" ## Module source location  in Private Module Registry
  version               = "0.3.4" ## Latest module version found here: https://terraform.caresource.corp/app/caresource/registry/private/modules
  vm_size               = "medium" ## Size of VM being requested: "Small, Medium, Large"
  datacenter            = "DAY" ## Datacenter the VM will be created: "DAY"
  environment           = "CRT" ## App environment for the server: "DEV, INT, CRT"
  app_name              = "TST" ## 3 letter app abbreviation
  server_number         = 2 ## Number of servers you want created 
  vsphere_cluster       = "DAYCRTHXCLST10" ## Vsphere cluster name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datacenter    = "DAY_CRT_HX" ## Vsphere datacenter name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datastore     = "DAYCRTHXCLST10_OS_02" ## Vsphere datastore name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_resource_pool = "DAYCRTHXCLST10/Resources" ## Vsphere resource pool name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_tag_category  = "Auto_Group" ## Tags group to be applied in vsphere
  vsphere_tag_name      = ["NeedToInventory", "Manual"] ## Tag names to be applied
  vsphere_folder        = "Test" ## Vsphere folder the server will be built in: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  network_cidr          = "10.121.132.0/22" ## Network CIDR that will be used to reserver an IP address for the server: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_network       = "239_APP_VRA" ## Vsphere network name the server will be assigned to: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  centadmin_p           = data.tss_secret.centadmin_p.value
  ticket_number         = "999991" ## CR number for tracking
  ssh_key_id            = "15344"  ## App team SSH key

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

module "daycrttest-2" {

  source                = "terraform.caresource.corp/caresource/virtualmachine-rhel/vsphere" ## Module source location  in Private Module Registry
  version               = "0.3.4" ## Latest module version found here: https://terraform.caresource.corp/app/caresource/registry/private/modules
  vm_size               = "medium" ## Size of VM being requested: "Small, Medium, Large"
  datacenter            = "DAY" ## Datacenter the VM will be created: "DAY"
  environment           = "CRT" ## App environment for the server: "DEV, INT, CRT"
  app_name              = "TEST" ## 3 letter app abbreviation
  server_number         = 2 ## Number of servers you want created 
  vsphere_cluster       = "DAYCRTHXCLST10" ## Vsphere cluster name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datacenter    = "DAY_CRT_HX" ## Vsphere datacenter name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datastore     = "DAYCRTHXCLST10_OS_02" ## Vsphere datastore name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_resource_pool = "DAYCRTHXCLST10/Resources" ## Vsphere resource pool name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_tag_category  = "Auto_Group" ## Tags group to be applied in vsphere
  vsphere_tag_name      = ["NeedToInventory", "Manual"] ## Tag names to be applied
  vsphere_folder        = "Test" ## Vsphere folder the server will be built in: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  network_cidr          = "10.121.132.0/22" ## Network CIDR that will be used to reserver an IP address for the server: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_network       = "239_APP_VRA" ## Vsphere network name the server will be assigned to: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  centadmin_p           = data.tss_secret.centadmin_p.value
  ticket_number         = "999991" ## CR number for tracking
  ssh_key_id            = "15344"  ## App team SSH key

}
output "vm_daycrttest-2_ipaddress" {
  value = module.daycrttest-2.ip_address
}

output "vm_daycrttest-2_fqdn" {
  value = module.daycrttest-2.fqdn
}

output "daycrttest-2_tags" {
  value = module.daycrttest-2.*.tags
}
