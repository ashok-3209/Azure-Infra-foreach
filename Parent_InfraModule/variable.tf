variable "rg" {
  type        = map(any)
  description = "Name of Resource Group"
}

variable "stg" {
  type        = map(any)
  description = "Name of Resource Group"
}

variable "vnet" {
  type        = map(any)
  description = "Name of Virtual Network"
}

variable "subnet" {
  type        = map(any)
  description = "Name of Subnet"
}

variable "keyvault" {
  type        = map(any)
  description = "Name of KV"
}

variable "secret" {
  type        = map(any)
  description = "Name of Secret"
}

variable "PIP" {
  type        = map(any)
  description = "Name of Secret"
}

variable "nsg" {
  type = map(any)

}

variable "vm_config" {
  type = map(any)
  
}

variable "sql_server_config" {
    type = map(any)
    description = "SQL Server"
  
}

variable "sql_db_config" {
     type = map(any)
  description = "SQL DB"
  
}