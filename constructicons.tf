resource "azurerm_resource_group" "az-rg" {
    name     = "More than meets the eye"
    location = "eastus"

    tags = {
        environment = "constructicons"
    }
}

resource "azurerm_virtual_network" "az-vn" {
    name                = "myVnet"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.az-rg.name

    tags = {
        environment = "constructicons"
    }
}

resource "azurerm_subnet" "az-subnet" {
    name                 = "mySubnet"
    resource_group_name  = azurerm_resource_group.az-rg.name
    virtual_network_name = azurerm_virtual_network.az-vn.name
    address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "az-pubip" {
    name                         = "myPublicIP"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.az-rg.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "constructicons"
    }
}

resource "azurerm_network_security_group" "az-nsg" {
    name                = "myNetworkSecurityGroup"
    location            = "eastus"
    resource_group_name = azurerm_resource_group.az-rg.name
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "constructicons"
    }
}

resource "azurerm_network_interface" "az-nic" {
    name                        = "myNIC"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.az-rg.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = "${azurerm_subnet.az-subnet.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "${azurerm_public_ip.az-pubip.id}"
    }

    tags = {
        environment = "constructicons"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "az-network" {
    network_interface_id      = azurerm_network_interface.az-nic.id
    network_security_group_id = azurerm_network_security_group.az-nsg.id
}

resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.az-rg.name
    }
    
    byte_length = 8
}

resource "azurerm_storage_account" "az-storage" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.az-rg.name
    location                    = "eastus"
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = {
        environment = "constructicons"
    }
}

# hook, scrapper, bonecrusher, longhaul, scavenger, mixmaster = devastator
#
resource "azurerm_linux_virtual_machine" "hook" {
    name                  = "hook"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.az-rg.name
    network_interface_ids = [azurerm_network_interface.az-nic.id]
    size                  = "Standard_B1S"

    os_disk {
        name              = "hook_root"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    computer_name  = "hook"
    admin_username = "azureuser"
    disable_password_authentication = true
        
    admin_ssh_key {
        username       = "azureuser"
        public_key     = file("/home/azureuser/.ssh/authorized_keys")
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.az-storage.primary_blob_endpoint
    }

    tags = {
        environment = "constructicons"
    }
}

