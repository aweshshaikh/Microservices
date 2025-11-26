terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-todo"
    storage_account_name = "bckupstg"
    container_name       = "acr"
    key                  = "dev.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "8680294f-df2b-4dc2-9732-345e2618ae81"
}
