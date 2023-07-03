#################################################
# MAIN VARIABLES                                #
#################################################

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

