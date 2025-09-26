terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

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

variable "ssh_public_key" {
  description = "SSH публічний ключ для автентифікації"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_subnet" "main" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.main.name
}

data "azurerm_network_interface" "main" {
  name                = var.network_interface_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_virtual_machine" "main" {
  name                = var.virtual_machine_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_public_ip" "main" {
  name                = try(reverse(split("/", data.azurerm_network_interface.main.ip_configuration[0].public_ip_address_id))[0], "")
  resource_group_name = data.azurerm_resource_group.main.name
}

locals {
  public_ip_address = try(data.azurerm_public_ip.main.ip_address, "")
  has_public_ip     = local.public_ip_address != ""
}

resource "local_file" "index_html" {
  filename = "index.html"
  content  = templatefile("${path.module}/index.html.tpl", {
    vm_name     = data.azurerm_virtual_machine.main.name
    vm_size     = data.azurerm_virtual_machine.main.size
    vm_location = data.azurerm_virtual_machine.main.location
    public_ip   = local.public_ip_address
  })
}

resource "local_file" "vm_info" {
  filename = "vm_info.txt"
  content  = <<-EOT
Інформація про віртуальну машину:
Назва: ${data.azurerm_virtual_machine.main.name}
Розмір: ${data.azurerm_virtual_machine.main.size}
Локація: ${data.azurerm_virtual_machine.main.location}
Публічна IP-адреса: ${local.public_ip_address}
Статус: ${data.azurerm_virtual_machine.main.power_state}
EOT
}

resource "null_resource" "nginx_setup" {
  count = local.has_public_ip ? 1 : 0

  connection {
    type     = "ssh"
    user     = var.admin_username
    password = var.admin_password
    host     = local.public_ip_address
    timeout  = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }

  provisioner "file" {
    source      = "${path.module}/index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown www-data:www-data /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html",
      "sudo systemctl restart nginx",
      "echo 'Nginx successfully installed and configured!'"
    ]
  }

  depends_on = [local_file.index_html]
}

output "public_ip_address" {
  description = "Public IP address of the existing VM"
  value       = local.public_ip_address
}

output "vm_name" {
  description = "Name of the existing VM"
  value       = data.azurerm_virtual_machine.main.name
}

output "vm_status" {
  description = "Power status of the existing VM"
  value       = data.azurerm_virtual_machine.main.power_state
}

output "ssh_connection" {
  description = "SSH connection string"
  value       = "ssh ${var.admin_username}@${local.public_ip_address}"
  sensitive   = true
}

output "nginx_url" {
  description = "URL to access Nginx"
  value       = "http://${local.public_ip_address}"
}