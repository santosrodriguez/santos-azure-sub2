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
    thycotic = {
      version = ">= 0.1.2"
      source  = "terraform.caresource.corp/caresource/thycotic"
    }
  }
}
