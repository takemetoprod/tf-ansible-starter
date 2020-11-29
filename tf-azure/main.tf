resource "azurerm_virtual_network" "sampleNetwork" {
  name                = "sampleNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rgSample.location
  resource_group_name = azurerm_resource_group.rgSample.name

  tags = {
      environment = "tfdemo"
  }
}

resource "azurerm_subnet" "sampleSubnet" {
  name                 = "sampleSubnet"
  resource_group_name  = azurerm_resource_group.rgSample.name
  virtual_network_name = azurerm_virtual_network.sampleNetwork.name
  address_prefixes       = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "myPublicIP"
    location                     = azurerm_resource_group.rgSample.location
    resource_group_name          = azurerm_resource_group.rgSample.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "tfdemo"
    }
}

resource "azurerm_network_interface" "exampleNic" {
  name                = "exampleNic"
  location            = azurerm_resource_group.rgSample.location
  resource_group_name = azurerm_resource_group.rgSample.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sampleSubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          =  azurerm_public_ip.myterraformpublicip.id
  }

  
}

resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "myNetworkSecurityGroup"
    location            = azurerm_resource_group.rgSample.location
    resource_group_name = azurerm_resource_group.rgSample.name
    
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

    tags = {
        environment = "Terraform Demo"
    }
}


resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.rgSample.name
  location            = azurerm_resource_group.rgSample.location
  size                = "Standard_A4_v2"
  admin_username      = var.username
  
  network_interface_ids = [
    azurerm_network_interface.exampleNic.id,
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb          =  30           
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}