provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rgSample" {
  name     = "rgSample"
  location = "eastus"
  tags = {
      environment = "tfdemo"
  }
}