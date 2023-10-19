data "tss_secret" "infoblox_username" {
  id    = var.infoblox_secret_id
  field = "Username"
}

data "tss_secret" "infoblox_secret" {
  id    = var.infoblox_secret_id
  field = "Password"
}

data "tss_secret" "nonprod_vsphere_username" {
  id    = var.nonprod_vsphere_secret_id
  field = "Username"
}

data "tss_secret" "nonprod_vsphere_secret" {
  id    = var.nonprod_vsphere_secret_id
  field = "Password"
}

data "tss_secret" "centadmin_p" {
  id    = var.centadmin_p_secret_id
  field = "Password"
}
