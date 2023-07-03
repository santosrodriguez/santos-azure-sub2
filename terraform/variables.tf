#################################################
# MAIN VARIABLES                                #
#################################################

# Change this variable to match the target subscription.
variable "sub_Name" {
  type        = string
  description = "Name of the target subscription"
  default     = "santos-azure-sub2"
}

# Change this variable to match the target subscription.
variable "subscription_id" {
  type        = string
  description = "Id of the LOCAL (target) subscription"
  default     = "d4693006-ef9a-4c42-a3ec-a6e69a58f5ee"
}


#Azure AD tenant ID
variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
  default     = "603b3704-d0cf-4517-9067-6afd49a51d1b"
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