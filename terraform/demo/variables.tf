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

variable "image_id" {
  type        = string
  description = "Идентификатор образа виртуальной машины"
}

variable "subnet_id" {
  type        = string
  description = "Идентификатор сети, в которой будет виртуальная машина"
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

variable "core_fraction" {
  type        = number
  description = "Доля ядра в процентах"
}

variable "disk_size" {
  type        = number
  description = "Размер диска"
}
