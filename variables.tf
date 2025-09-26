variable "resource_group_name" {
  description = "Назва існуючої групи ресурсів"
  type        = string
}

variable "virtual_network_name" {
  description = "Назва існуючої віртуальної мережі"
  type        = string
}

variable "subnet_name" {
  description = "Назва існуючої підмережі"
  type        = string
}

variable "network_interface_name" {
  description = "Назва існуючого мережевого інтерфейсу"
  type        = string
}

variable "virtual_machine_name" {
  description = "Назва існуючої віртуальної машини"
  type        = string
}

variable "admin_username" {
  description = "Ім'я адміністратора для підключення"
  type        = string
  sensitive   = true
}

variable "admin_password" {
  description = "Пароль адміністратора для підключення"
  type        = string
  sensitive   = true
  # Видалено значення за замовчуванням для безпеки
}

variable "storage_account_name" {
  description = "Ім'я storage account для стану Terraform"
  type        = string
  default     = "tfstate" # Замінити на реальне ім'я
}