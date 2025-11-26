locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "ElearnTeam"
    "Environment" = "dev"
  }
}

module "rg" {
  source      = "../../modules/az_rg"
  rgs         = var.rgs
  rg_tags     = local.common_tags
}

module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/acr"
  acrs       = var.acrs
  # acr_tags   = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/az_sql_server"
  sql_servers     = var.sql_servers
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/az_sql_db"
  sql_dbs     = var.sql_dbs
}

module "aks" {
  source      = "../../modules/aks"
  aks_clusters = var.aks_clusters
  # aks_tags     = local.common_tags
}


module "pip" {
  depends_on = [module.rg]

  source   = "../../modules/az_pip"
  public_ips = var.public_ips
  # tags     = local.common_tags
}

module "key_vault" {
  depends_on = [module.rg]
  source = "../../modules/akv"
  key_vaults = var.key_vaults
}

module "storage_account" {
  source = "../../modules/az_stg_acct"
  stgs = var.stgs
}
