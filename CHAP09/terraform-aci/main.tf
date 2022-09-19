provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "nickacidemobook" {
  name     = "nickdemoBook"
  location = "westus2"
}

variable "imageversion" {
  description = "Tag of the image to deploy"
  default = "v1"
}

variable "dockerhub-username" {
  description = "DockerHub username"
}


resource "azurerm_container_group" "nickaci-myapp" {
  name                = "aci-app"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.acidemobook.name
  ip_address_type     = "public"
  dns_name_label      = "nick_myapp-demo"
  os_type             = "linux"
  
  container {
    name   = "nickmyappdemo"
    image  = "docker.io/${var.dockerhub-username}/demobook:${var.imageversion}"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
