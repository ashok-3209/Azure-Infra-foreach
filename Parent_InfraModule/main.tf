module "rg" {
  source         = "../azurerm_resource_group"
  resource_group = var.rg
}

module "stg" {
  depends_on      = [module.rg]
  source          = "../azurerm_storage_account"
  storage_account = var.stg

}

module "vnet" {
  depends_on      = [module.rg]
  source          = "../azurerm_virtual_network"
  virtual_network = var.vnet

}

module "subnet" {
  depends_on  = [module.rg, module.vnet]
  source      = "../azurerm_subnet"
  subnet_name = var.subnet

}

module "keyvault" {
  depends_on = [module.rg]
  source     = "../azurerm_keyvault"
  key_vault  = var.keyvault

}

module "kvsecrect" {
  depends_on  = [module.keyvault]
  source      = "../azurerm_keyvault_secret"
  secret_name = var.secret
  key_vault   = var.keyvault

}

module "PIP" {
  depends_on = [module.rg]
  source     = "../azurerm_public_ip"
  public_ip  = var.PIP

}

module "nsg" {
  depends_on = [module.subnet,]
  source     = "../azurerm_nsg"
  nsg        = var.nsg
  subnet     = var.subnet

}

module "vm" {
  depends_on = [ module.rg, module.keyvault, module.kvsecrect, module.PIP, module.nsg]
  source = "../azurerm_virtual_machine"
  vm_config = var.vm_config
  subnet = var.subnet
  public_ip = var.PIP
  keyvault_name = var.keyvault
}

module "sqlserver" {
  depends_on = [ module.rg, module.keyvault, module.kvsecrect ]
  source = "../azurerm_sql_server"
  sql_server_config = var.sql_server_config
  
}

module "sqldb" {
  depends_on = [ module.sqlserver ]
  source = "../azurerm_sql_database"
  sql_db_config = var.sql_db_config
  # sql_server_config = var.sql_server_config
}