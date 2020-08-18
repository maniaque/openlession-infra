provider "yandex" {
  service_account_key_file  = "./keys/yandex/key.json"
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
  zone                      = var.zone
}

resource "yandex_compute_instance" "demo" {
  name = "hello-demo"

  count = 1

  resources {
    cores           = var.cores
    memory          = var.memory
    core_fraction   = var.core_fraction
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = var.disk_size
    }
  }

  network_interface {
    subnet_id     = var.subnet_id
    nat           = true
  }

  metadata = {
    ssh-keys = "${var.user}:${file("./keys/ssh/id_rsa.pub")}"
  }
}

resource "template_file" "inventory" {
  template = file("./terraform/templates/inventory.tpl")
  
  vars = {
    user = var.user
    hosts = "${join("\n", [for instance in yandex_compute_instance.demo : join("", [instance.name, " ansible_host=", instance.network_interface.0.nat_ip_address])] )}"
  }
}

output "demo" {
  value = {
    for instance in yandex_compute_instance.demo:
    instance.name => join(", ", [ instance.network_interface.0.nat_ip_address, instance.network_interface.0.ip_address ])    
  }
}

resource "local_file" "save_inventory" {
  content  = template_file.inventory.rendered
  filename = "./inventory"
}