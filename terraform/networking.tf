

##################################################
# LOCAL (Resource group) VARIABLE DEFINITIONS    #
##################################################

# Tags exclusive for this deployment for this resource group
variable "tags_santos-azure-sub2_infrastructure-rg" {
  type = map(any)
  default = {
    "business unit" = "IT"                                  #DO NOT CHANGE
    "support group" = "santos.rodriguez@hotmail.com"        #DO NOT CHANGE
    "product"       = "IT Common Services"                  #DO NOT CHANGE
    "Created by"   = "Terraform"                              #DO NOT CHANGE
    "environment"   = "Test"                                #Enter one of the following: PRD,CRT,INT,DEV,SBX
  }
}

#resource group variables
variable "santos-azure-sub2_infrastructure-rg" { default = "infrastructure_rg" }                #DO NOT CHANGE.
variable "santos-azure-sub2_networkwatcher-rg" { default = "NetworkWatcher_RG" }                #DO NOT CHANGE.

#vnet and subnet  variables
variable "santos-azure-sub2_infrastructure-rg_vnet1" { default = "hub-vnet1" }                #Name for VNET1 (e.g. environment-location-customer/app-vnet1 - dev-eastus-mdp-vnet1)
variable "santos-azure-sub2_infrastructure-rg_vnet1_cidr1" { default = ["10.33.0.0/16"] }     #Enter the CIDR Range (e.g.["xxx.xxx.xxx.xxx/20"] )
variable "santos-azure-sub2_infrastructure-rg_vnet1_subnet1" { default = "general_subnet" }   #DO NOT CHANGE
variable "santos-azure-sub2_infrastructure-rg_vnet1_address1" { default = ["10.35.1.0/24"] }  #Enter the Subnet Range (e.g.["xxx.xxx.xxx.xxx/22"] )

variable "santos-azure-sub2_infrastructure-rg_vnet2" { default = "spoke1-vnet1" }                #Name for VNET1 (e.g. environment-location-customer/app-vnet1 - dev-eastus-mdp-vnet1)
variable "santos-azure-sub2_infrastructure-rg_vnet2_cidr1" { default = ["10.34.0.0/16"] }     #Enter the CIDR Range (e.g.["xxx.xxx.xxx.xxx/20"] )
variable "santos-azure-sub2_infrastructure-rg_vnet2_subnet1" { default = "general_subnet" }   #DO NOT CHANGE
variable "santos-azure-sub2_infrastructure-rg_vnet2_address1" { default = ["10.36.1.0/24"] }  #Enter the Subnet Range (e.g.["xxx.xxx.xxx.xxx/22"] )

##################################################
# RESOURCE GROUP and SHARED RESOURCES            #
##################################################
resource "azurerm_resource_group" "santos-azure-sub2-infrastructure_rg" {
  name     = var.santos-azure-sub2_infrastructure-rg
  location = var.location
  tags     = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
}

resource "azurerm_resource_group" "santos-azure-sub2-networkwatcher_rg" {
  name     = var.santos-azure-sub2_networkwatcher-rg
  location = var.location
  tags     = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
}

# Random ID for unique naming
resource "random_id" "randomId_santos-azure-sub2-infrastructure_rg" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.santos-azure-sub2_infrastructure-rg
  }
  byte_length = 4
}
# Diagnostics diagnostics storage accounts
resource "azurerm_storage_account" "stdiagseus_santos-azure-sub2" {
  name                     = "stdiagseus${random_id.randomId_santos-azure-sub2-infrastructure_rg.hex}"
  resource_group_name      = var.santos-azure-sub2_infrastructure-rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags_santos-azure-sub2_infrastructure-rg

  blob_properties {
    delete_retention_policy {
      days = 90
    }
    container_delete_retention_policy {
      days = 90
    }
  }

  queue_properties {

    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 90
    }

    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 90
    }

    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 90
    }
  }
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_resource_group.santos-azure-sub2-infrastructure_rg
  ]
}

##################################################
# VNET1 (EastUS) resources                       #
##################################################


# VNET1 definition
resource "azurerm_virtual_network" "santos-azure-sub2_infrastructure-rg_vnet1" {
  name                = var.santos-azure-sub2_infrastructure-rg_vnet1
  address_space       = var.santos-azure-sub2_infrastructure-rg_vnet1_cidr1
  location            = var.location
  resource_group_name = var.santos-azure-sub2_infrastructure-rg
  dns_servers         = var.dns_entries_eastus
  tags                = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_resource_group.santos-azure-sub2-infrastructure_rg
  ]
}



# Subnet definitions
resource "azurerm_subnet" "santos-azure-sub2_infrastructure-rg_vnet1_subnet1" {
  name                 = var.santos-azure-sub2_infrastructure-rg_vnet1_subnet1
  resource_group_name  = var.santos-azure-sub2_infrastructure-rg
  virtual_network_name = azurerm_virtual_network.santos-azure-sub2_infrastructure-rg_vnet1.name
  address_prefixes     = var.santos-azure-sub2_infrastructure-rg_vnet1_address1
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
}


#Creating NSGs and Security Rules
resource "azurerm_network_security_group" "santos-azure-sub2_infrastructure-rg_nsg1" {
  name                = "nsg-general_subnet"
  location            = var.location
  resource_group_name = var.santos-azure-sub2_infrastructure-rg

  security_rule {
    name                       = "sr1-nsg1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_virtual_network.santos-azure-sub2_infrastructure-rg_vnet1
  ]
}



# Associate the NSG to subnets
resource "azurerm_subnet_network_security_group_association" "santos-azure-sub2_infrastructure-rg_vnet1_subnet1_nsg1" {
  subnet_id                 = azurerm_subnet.santos-azure-sub2_infrastructure-rg_vnet1_subnet1.id
  network_security_group_id = azurerm_network_security_group.santos-azure-sub2_infrastructure-rg_nsg1.id
}




# VNET1 Route table definition
resource "azurerm_route_table" "santos-azure-sub2_infrastructure-rg_vnet1_rtable" {
  name                          = "rt-${var.santos-azure-sub2_infrastructure-rg_vnet1}"
  location                      = var.location
  resource_group_name           = var.santos-azure-sub2_infrastructure-rg
  disable_bgp_route_propagation = false
  # CareSource Azure East US route definitions
  route {
    name                   = "CS-Default"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.115.2.134"
  }
  route {
    name                   = "CS-Internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.115.2.134"
  }

  tags = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_resource_group.santos-azure-sub2-infrastructure_rg
  ]
}


# VNET1 subnet route table associations
resource "azurerm_subnet_route_table_association" "santos-azure-sub2_infrastructure-rg_vnet1_subnet1" {
  subnet_id      = azurerm_subnet.santos-azure-sub2_infrastructure-rg_vnet1_subnet1.id
  route_table_id = azurerm_route_table.santos-azure-sub2_infrastructure-rg_vnet1_rtable.id
}



##################################################
# VNET2 (EastUS) resources                       #
##################################################

resource "azurerm_virtual_network" "santos-azure-sub2_infrastructure-rg_vnet2" {
  name                = var.santos-azure-sub2_infrastructure-rg_vnet2
  address_space       = var.santos-azure-sub2_infrastructure-rg_vnet2_cidr1
  location            = var.location
  resource_group_name = var.santos-azure-sub2_infrastructure-rg
  dns_servers         = var.dns_entries_eastus
  tags                = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_resource_group.santos-azure-sub2-infrastructure_rg
  ]
}

# Subnet definitions

resource "azurerm_subnet" "santos-azure-sub2_infrastructure-rg_vnet2_subnet1" {
  name                 = var.santos-azure-sub2_infrastructure-rg_vnet2_subnet1
  resource_group_name  = var.santos-azure-sub2_infrastructure-rg
  virtual_network_name = azurerm_virtual_network.santos-azure-sub2_infrastructure-rg_vnet2.name
  address_prefixes     = var.santos-azure-sub2_infrastructure-rg_vnet2_address1
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
}

#Creating NSGs and Security Rules
resource "azurerm_network_security_group" "santos-azure-sub2_infrastructure-rg_nsg2" {
  name                = "nsg-general_subnet2"
  location            = var.location
  resource_group_name = var.santos-azure-sub2_infrastructure-rg

  security_rule {
    name                       = "sr1-nsg1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_virtual_network.santos-azure-sub2_infrastructure-rg_vnet2
  ]
}


# Associate the NSG to subnets

resource "azurerm_subnet_network_security_group_association" "santos-azure-sub2_infrastructure-rg_vnet2_subnet1_nsg1" {
  subnet_id                 = azurerm_subnet.santos-azure-sub2_infrastructure-rg_vnet2_subnet1.id
  network_security_group_id = azurerm_network_security_group.santos-azure-sub2_infrastructure-rg_nsg2.id
}

# VNET1 Route table definition

resource "azurerm_route_table" "santos-azure-sub2_infrastructure-rg_vnet2_rtable" {
  name                          = "rt-${var.santos-azure-sub2_infrastructure-rg_vnet2}"
  location                      = var.location
  resource_group_name           = var.santos-azure-sub2_infrastructure-rg
  disable_bgp_route_propagation = false
  # CareSource Azure East US route definitions
  route {
    name                   = "Internal"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.115.2.134"
  }
  route {
    name                   = "Internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.115.2.134"
  }

  tags = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_resource_group.santos-azure-sub2-infrastructure_rg
  ]
}

# VNET1 subnet route table associations

resource "azurerm_subnet_route_table_association" "santos-azure-sub2_infrastructure-rg_vnet2_subnet1" {
  subnet_id      = azurerm_subnet.santos-azure-sub2_infrastructure-rg_vnet2_subnet1.id
  route_table_id = azurerm_route_table.santos-azure-sub2_infrastructure-rg_vnet2_rtable.id
}


##################################################
# Network Watcher                                #
##################################################

resource "azurerm_network_watcher" "santos-azure-sub2_networkwatcher-rg_networkwatcher" {
  name                = "NetworkWatcher_${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.santos-azure-sub2-networkwatcher_rg.name
  tags                = var.tags_santos-azure-sub2_infrastructure-rg
  lifecycle {
    ignore_changes = [
      tags, # Ignore changes to tags
    ]
  }
  depends_on = [
    azurerm_resource_group.santos-azure-sub2-networkwatcher_rg
  ]
}

resource "azurerm_network_watcher_flow_log" "santos-azure-sub2_networkwatcher-rg_flowlog1" {
  network_watcher_name      = azurerm_network_watcher.santos-azure-sub2_networkwatcher-rg_networkwatcher.name
  resource_group_name       = azurerm_resource_group.santos-azure-sub2-networkwatcher_rg.name
  name                      = azurerm_network_security_group.santos-azure-sub2_infrastructure-rg_nsg1.name
  network_security_group_id = azurerm_network_security_group.santos-azure-sub2_infrastructure-rg_nsg1.id
  storage_account_id        = azurerm_storage_account.stdiagseus_santos-azure-sub2.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 90
  }
}