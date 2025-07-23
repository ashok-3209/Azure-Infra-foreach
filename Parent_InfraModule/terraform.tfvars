rg = {
  rg1 = {
    rgname   = "dev-rg-tst-prep"
    location = "West US"
  }
}

stg = {
  stg1 = {
    stgname  = "devstgtstprep"
    location = "West US"
    rgname   = "dev-rg-tst-prep"
  }
}

vnet = {
  vnet1 = {
    vnet_name     = "dev-vnet-tst-prep"
    location      = "West US"
    rgname        = "dev-rg-tst-prep"
    address_space = ["10.0.0.0/16"]
  }
}

subnet = {
  subnet1 = {
    subnet_name      = "dev-web-tst-prep"
    rgname           = "dev-rg-tst-prep"
    vnet_name        = "dev-vnet-tst-prep"
    address_prefixes = ["10.0.0.0/17"]
  }

  subnet2 = {
    subnet_name      = "dev-db-tst-prep"
    rgname           = "dev-rg-tst-prep"
    vnet_name        = "dev-vnet-tst-prep"
    address_prefixes = ["10.0.128.0/17"]
  }
}

keyvault = {
  kv1 = {
    key_vault = "dev-kv-tst-prep"
    location  = "West US"
    rgname    = "dev-rg-tst-prep"
  }

}

secret = {
  username = {
    name  = "username"
    value = "opc"
  }

  password = {
    name  = "password"
    value = "V*nhel#ing@123"
  }

   sql-username = {
    name  = "sql-username"
    value = "sqladmin1"
  }

  sql-password = {
    name  = "sql-password"
    value = "S@1r8uZx!Lp3Nq7F"
  }
}

PIP = {
  PublicIP = {
    pip_name          = "dev-pip-tst-front"
    rgname            = "dev-rg-tst-prep"
    location          = "West US"
    allocation_method = "Static"
  }
  PublicIP2 = {
    pip_name          = "dev-pip-tst-back"
    rgname            = "dev-rg-tst-prep"
    location          = "West US"
    allocation_method = "Static"
  }
}

nsg = {
  frontend-nsg = {
    nsg_name                                   = "az-fnsg-prep"
    location                                   = "West US"
    rgname                                     = "dev-rg-tst-prep"
    subnet_name   = "dev-web-tst-prep"     # ✅ Needed
    vnet_name     = "dev-vnet-tst-prep"      # ✅ Needed
    security_rule_name                         = "Allow-SSH-HTTP"
    security_rule_priority                     = "100"
    security_rule_direction                    = "Inbound"
    security_rule_access                       = "Allow"
    security_rule_protocol                     = "Tcp"
    security_rule_source_port_range            = "*"
    security_rule_destination_port_range       = "*"
    security_rule_access_source_address_prefix = "*"
    security_rule_destination_address_prefix   = "*"
  }
  backend-nsg = {
    nsg_name                                   = "az-bnsg-prep"
    location                                   = "West US"
    rgname                                     = "dev-rg-tst-prep"
    subnet_name   = "dev-db-tst-prep"       # ✅ Needed
    vnet_name     = "dev-vnet-tst-prep"      # ✅ Needed
    security_rule_name                         = "Allow-SSH-HTTP"
    security_rule_priority                     = "101"
    security_rule_direction                    = "Inbound"
    security_rule_access                       = "Allow"
    security_rule_protocol                     = "Tcp"
    security_rule_source_port_range            = "*"
    security_rule_destination_port_range      = "*"
    security_rule_access_source_address_prefix = "*"
    security_rule_destination_address_prefix   = "*"
  }

}


vm_config = {
  frontend-vm = {
    vm_name = "azdevlwebvm01"
    nic_name = "azdevlwebvm01-nic"
    rgname = "dev-rg-tst-prep"
    location = "West US"
    subnet_name = "dev-web-tst-prep"
    vnet_name = "dev-vnet-tst-prep"
    pip_name = "dev-pip-tst-front"
    key_vault= "dev-kv-tst-prep"
    nsg_name = "az-fnsg-prep"
    username = "username"
    password = "password"
    size = "Standard_F2"
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"

  }
    backend-vm = {
    vm_name = "azdevlwebvm02"
    nic_name = "azdevlwebvm02-nic"
    rgname = "dev-rg-tst-prep"
    location = "West US"
    subnet_name = "dev-web-tst-prep"
    vnet_name = "dev-vnet-tst-prep"
    pip_name = "dev-pip-tst-back"
    key_vault = "dev-kv-tst-prep"
    nsg_name = "az-bnsg-prep"
    username = "username"
    password = "password"
    size = "Standard_F2"
    offer     = "UbuntuServer"
    publisher = "Canonical"
    sku       = "18.04-LTS"
    version   = "latest"

  }
}

sql_server_config = {
  sqlserver1 = {
    sql_server = "azdevlsqlvm01"
    rgname = "dev-rg-tst-prep"
    location = "West US"
    key_vault = "dev-kv-tst-prep"
    sql-username = "sql-username"
    sql-password = "sql-password"
    version = "12.0"
    tls_version = "1.2"
  }
}

sql_db_config = {
  sqldb = {
    sql_db_name = "azdevlsqldb"
    sql_server = "azdevlsqlvm01"
    rgname = "dev-rg-tst-prep"
    collation = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb = "2"
  }
}