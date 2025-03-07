module "cloud_sql" {
  source = "../"

  name             = "my-database"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  project_id       = "my-project"

  settings = {
    tier            = "db-f1-micro"
    disk_size       = 20
    disk_type       = "PD_SSD"
    disk_autoresize = true

    backup_configuration = {
      enabled            = true
      binary_log_enabled = true
      start_time        = "23:00"
    }

    ip_configuration = {
      ipv4_enabled        = true
      private_network     = "projects/my-project/global/networks/my-vpc"
      allocated_ip_range  = "my-range"
      authorized_networks = {
        name  = "office"
        value = "192.168.1.0/24"
      }
    }

    database_flags = [
      {
        name  = "max_connections"
        value = "100"
      }
    ]

    maintenance_window = {
      day  = 7
      hour = 23
    }
  }

  deletion_protection = true
}
