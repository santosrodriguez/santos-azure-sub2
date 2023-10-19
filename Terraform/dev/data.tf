data "thycotic_secret" "infoblox_credential" {
  mixed = var.infoblox_secret_id
}

data "thycotic_secret" "nonprod_vsphere_credential" {
  mixed = var.nonprod_vsphere_secret_id
}

data "thycotic_secret" "centadmin_p" {
  mixed = var.centadmin_p_secret_id
}
