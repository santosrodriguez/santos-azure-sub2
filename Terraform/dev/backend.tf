terraform {
  cloud {
    hostname     = "terraform.caresource.corp"
    organization = "caresource"

    workspaces {
      name = "devops-playground-dev"
    }
  }
}