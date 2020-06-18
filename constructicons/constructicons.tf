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

