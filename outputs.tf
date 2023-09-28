output "sql_id" {
  description = "The ID of the Cloud SQL."
  value       = google_sql_database.main.id
}

output "instance_id" {
  description = "The self_link of the Cloud SQL instance."
  value       = google_sql_database_instance.main.self_link
}

output "connection_name" {
  description = "The connection name of the Cloud SQL instance."
  value       = google_sql_database_instance.main.connection_name
}

output "ip_address" {
  description = "The IP address of the Cloud SQL instance."
  value       = google_sql_database_instance.main.public_ip_address != "" ? google_sql_database_instance.main.public_ip_address : google_sql_database_instance.main.private_ip_address
}
