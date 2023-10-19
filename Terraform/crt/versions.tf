terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.2.0"
    }
    infoblox = {
      source  = "infobloxopen/infoblox"
      version = "2.2.0"
    }
    tss = {
      source  = "DelineaXPM/tss"
      version = "2.0.0"
    }
  }
}
