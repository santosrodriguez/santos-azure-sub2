provider "vsphere" {
  user                 = data.tss_secret.nonprod_vsphere_username.value
  password             = data.tss_secret.nonprod_vsphere_secret.value
  vsphere_server       = var.nonprod_vsphere_server
  allow_unverified_ssl = true
}

provider "infoblox" {
  username = data.tss_secret.infoblox_username.value
  password = data.tss_secret.infoblox_secret.value
  server   = var.infoblox_server
}

provider "tss" {
  username   = "caresource\\${var.tss_username}"
  password   = var.tss_password
  server_url = "https://thycotic.caresource.corp/SecretServer"

}