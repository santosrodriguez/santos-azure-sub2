# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias = "sub1"
  features {}

  client_id       = "da407e9f-5e21-47d4-808e-21382cabf2b5	"
  client_secret   = "zaK8Q~ZdU6RMj97dlU3pMWwPIehJU~rMYlfY-co5	"
  tenant_id       = "603b3704-d0cf-4517-9067-6afd49a51d1b"
  subscription_id = "2aa7f81a-c2cc-41f6-ae8e-468be407d0de	"
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


provider "azurerm" {
  alias = "sub2"
  features {}

  client_id       = "39b4f478-ebb8-4338-815e-341faaf33745"
  client_secret   = "KwY8Q~QVjZhH5mr~.gPblp5FJHhp7qXYwpTq9cIS"
  tenant_id       = "603b3704-d0cf-4517-9067-6afd49a51d1b"
  subscription_id = "d4693006-ef9a-4c42-a3ec-a6e69a58f5ee"
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