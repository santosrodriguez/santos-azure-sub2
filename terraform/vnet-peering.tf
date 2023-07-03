##################################################
# PROVIDER BLOCK DEFINITIONS                     #
# Individual provider blocks for local and       #
# CS-PNP-CommonServicesInfra subscriptions for   #
# peering to PaloEW VNETs                        #
##################################################

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  alias           = "localsubscription" # Do not modify the alias, as it will break individual resource blocks.
  subscription_id = var.subscription_id
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  alias           = "santos-azure-sub1" # Do not modify the alias, as it will break individual resource blocks.
  subscription_id = "2aa7f81a-c2cc-41f6-ae8e-468be407d0de"
}
/*

##################################################
# EXISTING (unmanaged) RESOURCES                 #
##################################################

data "azurerm_resource_group" "infrastructure-rg" { # Firewall Resource Group on CS-PNP-COMMONSERVICESINFRA subscription.
  name     = "infrastructure-rg"
  provider = azurerm.santos-azure-sub1
}

data "azurerm_virtual_network" "prd-eastus-paloew-vnet1" { # paloew-eastus vnet information
  provider            = azurerm.cs-pnp-commonservicesinfra
  name                = "hub-vnet1"
  resource_group_name = data.azurerm_resource_group.infrastructure-rg.name
}

*/


##################################################
# VNET1 peering - vnets in same sub      #
##################################################

# VNET1 (hub) to VNET2 (spoke)
resource "azurerm_virtual_network_peering" "santos-azure-sub1_infrastructure-rg_vnet1_x_santos-azure-sub1_infrastructure-rg_vnet2" { # local VNET1 peering
  name                         = azurerm_virtual_network.santos-azure-sub1_infrastructure-rg_vnet2.name
  resource_group_name          = var.santos-azure-sub1_infrastructure-rg
  virtual_network_name         = azurerm_virtual_network.santos-azure-sub2_infrastructure-rg_vnet3.name
  remote_virtual_network_id    = azurerm_virtual_network.santos-azure-sub1_infrastructure-rg_vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
  depends_on = [
    azurerm_virtual_network.santos-azure-sub2_infrastructure-rg_vnet3,
    azurerm_virtual_network.santos-azure-sub1_infrastructure-rg_vnet1
  ]
}

# VNET2 (hub) to VNET1 (spoke)
resource "azurerm_virtual_network_peering" "santos-azure-sub1_infrastructure-rg_vnet1_x_santos-azure-sub2_infrastructure-rg_vnet3" { # local VNET1 peering
  name                         = azurerm_virtual_network.santos-azure-sub1_infrastructure-rg_vnet1.name
  resource_group_name          = var.santos-azure-sub1_infrastructure-rg
  virtual_network_name         = azurerm_virtual_network.santos-azure-sub1_infrastructure-rg_vnet1.name
  remote_virtual_network_id    = azurerm_virtual_network.santos-azure-sub2_infrastructure-rg_vnet3.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
  depends_on = [
    azurerm_virtual_network.santos-azure-sub1_infrastructure-rg_vnet1,
    azurerm_virtual_network.santos-azure-sub1_infrastructure-rg_vnet2
  ]
}
