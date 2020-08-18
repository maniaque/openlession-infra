provider "yandex" {
  service_account_key_file  = "./keys/yandex/key.json"
  cloud_id                  = var.cloud_id
  folder_id                 = var.folder_id
  zone                      = var.zone
}

resource "yandex_kubernetes_cluster" "kubernetes_cluster" {
  name                    = "demo-kubernetes-cluster"
  service_account_id      = var.service_account_id
  node_service_account_id = var.service_account_id
  release_channel         = "RAPID"
  network_id              = var.network_id

  master {
    zonal {
      zone = var.zone
    }

    version   = "1.18"
    public_ip = true

    maintenance_policy {
      auto_upgrade = false
    }
  }
}

resource "yandex_kubernetes_node_group" "worker-node" {
  cluster_id  = yandex_kubernetes_cluster.kubernetes_cluster.id
  name        = "node"
  description = "Worker nodes"

  instance_template {
    platform_id = "standard-v1"
    nat         = true

    resources {
      memory = var.cores
      cores  = var.memory
    }

    boot_disk {
      type = "network-hdd"
      size = var.disk_size
    }

    metadata = {
      ssh-keys = "${var.user}:${file("./keys/ssh/id_rsa.pub")}"
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    auto_scale {
      min = 2
      initial = 2
      max = 5
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  maintenance_policy {
    auto_upgrade = false
    auto_repair  = true
  }
}