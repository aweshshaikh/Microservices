locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "AKSTeam"
    "Environment" = "dev"
  }
}

module "azurerm_rg" {
  source      = "../../modules/az_rg"
  rgs         = var.rgs
  rg_tags     = local.common_tags
}

module "azurerm_acr" {
  depends_on = [module.azurerm_rg]
  source     = "../../modules/acr"
  acrs       = var.acrs
  # acr_tags   = local.common_tags
}

module "azurerm_mssql_server" {
  depends_on      = [module.azurerm_rg]
  source          = "../../modules/az_sql_server"
  sql_servers     = var.sql_servers
}

module "azurerm_mssql_database" {
  depends_on  = [module.azurerm_mssql_server]
  source      = "../../modules/az_sql_db"
  sql_dbs     = var.sql_dbs
}

module "azurerm_aks" {
  source      = "../../modules/aks"
  aks_clusters = var.aks_clusters
  # aks_tags     = local.common_tags
}


module "azurerm_pip" {
  depends_on = [module.azurerm_rg]

  source   = "../../modules/az_pip"
  public_ips = var.public_ips
  # tags     = local.common_tags
}

module "azurerm_key_vault" {
  depends_on = [module.azurerm_rg]
  source = "../../modules/akv"
  key_vaults = var.key_vaults
}

module "azurerm_storage_account" {
  source = "../../modules/az_stg_acct"
  stgs = var.stgs
}
