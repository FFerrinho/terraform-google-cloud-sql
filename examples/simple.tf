module "cloud_sql" {
  source = "../"

  name             = "my-database"
  region           = "us-central1"
  database_version = "MYSQL_8_0"

  settings = {
    tier = "db-f1-micro"
    ip_configuration = {
      ipv4_enabled = true
    }
  }
}
