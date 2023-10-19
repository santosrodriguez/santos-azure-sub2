# A lot of values in the below module block will need to be obtained from Platform Engineering. This is to ensure the servers being built have been requested by the correct infrastructure teams and spec'd accordingly.
# Once all the information needed is obtained replace any placehoders < > with the real values
module "testvm" {
  source                = "terraform.caresource.corp/caresource/virtualmachine-rhel/vsphere" ## Module source location  in Private Module Registry
  version               = "0.3.4" ## Latest module version found here: https://terraform.caresource.corp/app/caresource/registry/private/modules
  vm_size               = "small" ## Size of VM being requested: "Small, Medium, Large"
  datacenter            = "DAY" ## Datacenter the VM will be created: "DAY, CIN, ALP"
  environment           = "PRD" ## App environment for the server: "PRD"
  app_name              = "TST" ## 3 letter app abbreviation
  server_number         = 2 ## Number of servers you want created 
  vsphere_cluster       = "DAYPRDPURE03" ## Vsphere cluster name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datacenter    = "DAY-Datacenter" ## Vsphere datacenter name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datastore     = "DAYPRDPURE03_OS_03" ## Vsphere datastore name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_resource_pool = "DAYPRDPURE03/Resources" ## Vsphere resource pool name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING working example (CLUSTER/Resources)
  vsphere_tag_category  = "Auto_Group" ## Tags group to be applied in vsphere
  vsphere_tag_name      = ["NeedToInventory", "Manual"] ## Tag names to be applied
  vsphere_folder        = "Test" ## Vsphere folder the server will be built in: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  network_cidr          = "10.120.14.0/24" ## Network CIDR that will be used to reserver an IP address for the server: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_network       = "122_PROD_NEW_APP_RANGE" ## Vsphere network name the server will be assigned to: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  centadmin_p           = data.tss_secret.centadmin_p.value
  ticket_number         = "Incident number for the request" ## Ticket number for tracking
  ssh_key_id            = "15658" #terratest key will need to change when we create prod vms
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

module "dayprdpemgt101" {
  source                = "terraform.caresource.corp/caresource/virtualmachine-rhel/vsphere" ## Module source location  in Private Module Registry
  version               = "0.3.4" ## Latest module version found here: https://terraform.caresource.corp/app/caresource/registry/private/modules
  vm_size               = "small" ## Size of VM being requested: "Small, Medium, Large"
  datacenter            = "DAY" ## Datacenter the VM will be created: "DAY, CIN, ALP"
  environment           = "PRD" ## App environment for the server: "PRD"
  app_name              = "PEMGT" ## 3 letter app abbreviation
  server_number         = 1 ## Number of servers you want created 
  vsphere_cluster       = "DAYPRDPURE03" ## Vsphere cluster name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datacenter    = "DAY-Datacenter" ## Vsphere datacenter name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_datastore     = "DAYPRDPURE03_OS_03" ## Vsphere datastore name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_resource_pool = "DAYPRDPURE03/Resources" ## Vsphere resource pool name: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING working example (CLUSTER/Resources)
  vsphere_tag_category  = "Auto_Group" ## Tags group to be applied in vsphere
  vsphere_tag_name      = ["NeedToInventory", "Manual"] ## Tag names to be applied
  vsphere_folder        = "Test" ## Vsphere folder the server will be built in: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  network_cidr          = "10.120.14.0/24" ## Network CIDR that will be used to reserver an IP address for the server: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  vsphere_network       = "122_PROD_NEW_APP_RANGE" ## Vsphere network name the server will be assigned to: NEEDS TO BE OBTAINED FROM PLATFORM ENGINEERING
  centadmin_p           = data.tss_secret.centadmin_p.value
  ticket_number         = "Incident number for the request" ## Ticket number for tracking
  ssh_key_id            = "15658" #terratest key will need to change when we create prod vms
}

output "vm_dayprdpemgt101_ipaddress" {
  value = module.dayprdpemgt101.ip_address
}

output "vm_dayprdpemgt101_fqdn" {
  value = module.dayprdpemgt101.fqdn
}

output "dayprdpemgt101_tags" {
  value = module.dayprdpemgt101.*.tags
}