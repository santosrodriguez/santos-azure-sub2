terraform {
  cloud {
    hostname     = "terraform.caresource.corp"
    organization = "caresource"

    workspaces {
      name = "<Workspace Name>"
    }
  }
}