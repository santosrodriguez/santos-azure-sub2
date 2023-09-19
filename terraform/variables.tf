##########################
## General VARIABLES      #
##########################

# Change this variable to match the target subscription.
variable "sub_Name" {
  type        = string
  description = "Name of the target subscription"
  default     = "santos-azure-sub2"
}


# Region where the resource will be deployed
variable "location" {
  type        = string
  description = "Location in azure where resources will be created."
  default     = "eastus"
}

# DNS servers for East US
variable "dns_entries_eastus" {
  type        = list(string)
  description = "Set custom dns config. If no values specified, this defaults to Azure DNS"
  default     = ["10.115.10.5", "10.115.10.6"]
}




##########################
## Providers VARIABLES  ##
##########################

### The variables below are set in Terraform Cloud. Empty variables are required to be set here for the Terraform cloud variables to work

# Change this variable to match the target subscription.
variable "subscription_id" {
  type        = string
  description = "Id of the LOCAL (target) subscription"
}

#Azure AD tenant ID
variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
}
variable "client_id" {}
variable "client_secret" {}




######################
## Virtual Networks ##
######################

#Varibles related to Vnet 2 : spoke

variable "vnet2_resource_group_name" {
type = string
description = "name of the ressource group"
}
variable "vnet2_name" {
type = string
description = "Names of the spoke virtual network"
}
variable "vnet2_id" {
description = "Id of the spoke virtual network"
}
variable "allow_virtual_network_access_vnet2_to_vnet1" {
type = bool
description = "(Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. default to true."
default = true
}
variable "allow_forwarded_traffic_vnet2_to_vnet1" {
type = bool
description = "(Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. default to false."
default = true
}
variable "allow_gateway_transit_vnet2_to_vnet1" {
type = bool
description = "(Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network."
default = false
}
variable "use_remote_gateways_vnet2_to_vnet1" {
type = bool
description = "(Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. default to false."
default = false
}

#variables related to Vnet 1 : hub
variable "vnet1_resource_group_name" {
type = string
description = "name of the ressource group"
}
variable "vnet1_name" {
type = string
description = "Names of the hub virtual network"
}
variable "vnet1_id" {
description = "Id of the spoke virtual network"
}
variable "allow_virtual_network_access_vnet1_to_vnet2" {
type = bool
description = "(Optional) Controls if the VMs in the remote virtual network can access VMs in the local virtual network. default to true."
default = true
}
variable "allow_forwarded_traffic_vnet1_to_vnet2" {
type = bool
description = "(Optional) Controls if forwarded traffic from VMs in the remote virtual network is allowed. default to false."
default = true
}
variable "allow_gateway_transit_vnet1_to_vnet2" {
type = bool
description = "(Optional) Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network."
default = true
}
variable "use_remote_gateways_vnet1_to_vnet2" {
type = bool
description = "(Optional) Controls if remote gateways can be used on the local virtual network. If the flag is set to true, and allow_gateway_transit on the remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway. default to false."
default = false
}
variable "vnet2_client_id" {
description = "vnet2 SP creds for provider"
}
variable "vnet2_tenant_id" {
description = "vnet2 SP creds for provider"
}
variable "vnet2_client_secret" {
description = "vnet2 SP creds for provider"
}
variable "vnet2_subscription_id" {
description = "vnet2 SP creds for provider"
}
variable "vnet1_client_id" {
description = "vnet1 SP creds for provider"
}
variable "vnet1_tenant_id" {
description = "vnet1 SP creds for provider"
}
variable "vnet1_client_secret" {
description = "vnet1 SP creds for provider"
}
variable "vnet1_subscription_id" {
description = "vnet1 SP creds for provider"
}