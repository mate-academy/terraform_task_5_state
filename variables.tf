variable "resource_group_name" {
  description = "Назва існуючої групи ресурсів"
  type        = string
  default     = "my-resource-group"
}

variable "virtual_network_name" {
  description = "Назва існуючої віртуальної мережі"
  type        = string
  default     = "my-vnet"
}

variable "subnet_name" {
  description = "Назва існуючої підмережі"
  type        = string
  default     = "my-subnet"
}

variable "network_interface_name" {
  description = "Назва існуючого мережевого інтерфейсу"
  type        = string
  default     = "my-nic"
}

variable "virtual_machine_name" {
  description = "Назва існуючої віртуальної машини"
  type        = string
  default     = "my-vm"
}

variable "admin_username" {
  description = "Ім'я адміністратора для підключення"
  type        = string
  sensitive   = true
  default     = "adminuser"
}

variable "admin_password" {
  description = "Пароль адміністратора для підключення"
  type        = string
  sensitive   = true
  default     = "Password1234!"
}