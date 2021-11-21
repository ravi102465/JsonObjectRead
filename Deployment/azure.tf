terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.86.0"
    }
  }

  required_version = "=0.14.9"
  //required_version = "=1.0.11"
  backend "azurerm" {
    container_name = "tfstate"
    key            = "terraform.deployment.tfplan"
  }
}

provider "azurerm" {
  features {}
}

