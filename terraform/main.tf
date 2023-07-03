# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "da407e9f-5e21-47d4-808e-21382cabf2b5"
  client_secret   = "zaK8Q~ZdU6RMj97dlU3pMWwPIehJU~rMYlfY-co5"
  tenant_id       = "603b3704-d0cf-4517-9067-6afd49a51d1b"
  subscription_id = "2aa7f81a-c2cc-41f6-ae8e-468be407d0de"
}
terraform {
  backend "remote" {
    organization = "santosrodriguez"

    workspaces {
      name = "test"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}