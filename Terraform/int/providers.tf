provider "vsphere" {
  user                 = "caresource\\${data.thycotic_secret.nonprod_vsphere_credential.username}"
  password             = data.thycotic_secret.nonprod_vsphere_credential.password
  vsphere_server       = var.nonprod_vsphere_server
  allow_unverified_ssl = true
}

provider "infoblox" {
  username = data.thycotic_secret.infoblox_credential.username
  password = data.thycotic_secret.infoblox_credential.password
  server   = var.infoblox_server
}

provider "thycotic" {
  host     = "thycotic.caresource.corp"
  username = var.tss_username
  password = var.tss_password
  domain   = "caresource"
  mfa      = false
  site     = 1
}
