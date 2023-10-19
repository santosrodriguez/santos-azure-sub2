### vsphere variables
variable "centadmin_p_secret_id" {
  type        = string
  description = "centadmin_p"
}

variable "nonprod_vsphere_secret_id" {
  type        = string
  description = "Thycotic secret ID for nonprod vshpere credentials"

}

variable "prod_vsphere_secret_id" {
  type        = string
  description = "Thycotic secret ID for prod vshpere credentials"

}

variable "nonprod_vsphere_server" {
  type        = string
  description = "Server name for nonprod vshpere"

}

variable "prod_vsphere_server" {
  type        = string
  description = "Server name for prod vshpere"

}

variable "infoblox_server" {
  type        = string
  description = "Server URL that will be used by the Infoblox provider"

}

variable "infoblox_secret_id" {
  type        = string
  description = "Thycotic secret ID for Infoblox service account"

}

### Thycotic variables
variable "tss_username" {
  type        = string
  description = "SVC account name used to authenitcate with Thycotic"

}

variable "tss_password" {
  type        = string
  description = "SVC account password used to authenitcate with Thycotic"

}

