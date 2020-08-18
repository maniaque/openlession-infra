variable "cloud_id" {
  type        = string
  description = "Идентификатор облака в Яндексе"
}

variable "folder_id" {
  type        = string
  description = "Идентификатор каталога в облаке"
}

variable "zone" {
  type        = string
  description = "Имя зоны"
}

variable "network_id" {
  type        = string
  description = "Идентификатор сети"
}

variable "user" {
  type        = string
  description = "Имя пользователя для доступа к виртуальной машине"
}

variable "cores" {
  type        = number
  description = "Количество ядер"
}

variable "memory" {
  type        = number
  description = "Объем оперативной памяти в гигабайтах"
}

variable "disk_size" {
  type        = number
  description = "Размер диска"
}

variable "service_account_id" {
  type        = string
  description = "Идентификатор сервисного аккаунта"
}