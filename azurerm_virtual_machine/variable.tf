variable "subnet" {
    type = map(any)
    description = "Subnet Name of VM"
  
}

variable "public_ip" {
    type = map(any)
    description = "PIP Name of VM"
  
}

variable "vm_config" {
    type = map(any)
    description = "Name of Virtual Machine"
}

variable "keyvault_name" {
  type = map(any)
  description = "Keyvault"
  
}