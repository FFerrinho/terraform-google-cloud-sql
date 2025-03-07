# Generate a random string suffix for unique naming.
resource "random_string" "main" {
  length  = 4
  special = false
  upper   = false
}

# Create the main database
resource "google_sql_database" "main" {
  name            = var.name
  instance        = google_sql_database_instance.main.name
  charset         = var.charset
  collation       = var.collation
  project         = var.project_id
  deletion_policy = var.deletion_policy
}

# Create the Cloud SQL instance with all supported configurations
resource "google_sql_database_instance" "main" {
  region = var.region

  # Dynamic settings block for all instance configurations
  dynamic "settings" {
    for_each = var.settings != null ? [var.settings] : []
    content {
      tier                        = settings.value.tier
      edition                     = settings.value.edition
      user_labels                 = settings.value.user_labels
      activation_policy           = settings.value.activation_policy
      availability_type           = settings.value.availability_type
      collation                   = settings.value.collation
      connector_enforcement       = settings.value.connector_enforcement
      deletion_protection_enabled = settings.value.deletion_protection_enabled
      disk_autoresize             = settings.value.disk_autoresize
      disk_autoresize_limit       = settings.value.disk_autoresize_limit
      disk_size                   = settings.value.disk_size
      disk_type                   = settings.value.disk_type
      pricing_plan                = settings.value.pricing_plan
      time_zone                   = settings.value.time_zone

      # Advanced machine configuration
      dynamic "advanced_machine_features" {
        for_each = settings.value.advanced_machine_features != null ? [settings.value.advanced_machine_features] : []
        content {
          threads_per_core = advanced_machine_features.value.threads_per_core
        }
      }

      # Database flags for engine customization
      dynamic "database_flags" {
        for_each = settings.value.database_flags != null ? [settings.value.database_flags] : []
        content {
          name  = database_flags.value.name
          value = database_flags.value.value
        }
      }

      # Active Directory integration settings
      dynamic "active_directory_config" {
        for_each = settings.value.active_directory_config != null ? [settings.value.active_directory_config] : []
        content {
          domain = active_directory_config.value.domain
        }
      }

      dynamic "data_cache_config" {
        for_each = settings.value.data_cache_config != null ? [settings.value.data_cache_config] : []
        content {
          data_cache_enabled = data_cache_config.value.data_cache_enabled
        }
      }

      dynamic "deny_maintenance_period" {
        for_each = settings.value.deny_maintenance_period != null ? [settings.value.deny_maintenance_period] : []
        content {
          start_date = deny_maintenance_period.value.start_date
          end_date   = deny_maintenance_period.value.end_date
          time       = deny_maintenance_period.value.time
        }
      }

      dynamic "sql_server_audit_config" {
        for_each = settings.value.sql_server_audit_config != null ? [settings.value.sql_server_audit_config] : []
        content {
          bucket             = sql_server_audit_config.value.bucket
          upload_interval    = sql_server_audit_config.value.upload_interval
          retention_interval = sql_server_audit_config.value.retention_interval
        }
      }

      dynamic "backup_configuration" {
        for_each = settings.value.backup_configuration != null ? [settings.value.backup_configuration] : []
        content {
          binary_log_enabled             = backup_configuration.value.binary_log_enabled
          enabled                        = backup_configuration.value.enabled
          start_time                     = backup_configuration.value.start_time
          location                       = backup_configuration.value.location
          point_in_time_recovery_enabled = backup_configuration.value.point_in_time_recovery_enabled
          transaction_log_retention_days = backup_configuration.value.transaction_log_retention_days
          dynamic "backup_retention_settings" {
            for_each = backup_configuration.value.backup_retention_settings != null ? [backup_configuration.value.backup_retention_settings] : []
            content {
              retained_backups = backup_retention_settings.value.retained_backups
              retention_unit   = backup_retention_settings.value.retention_unit
            }
          }
        }
      }

      dynamic "ip_configuration" {
        for_each = settings.value.ip_configuration != null ? [settings.value.ip_configuration] : []
        content {
          ipv4_enabled                                  = ip_configuration.value.ipv4_enabled
          private_network                               = ip_configuration.value.private_network
          ssl_mode                                      = ip_configuration.value.ssl_mode
          allocated_ip_range                            = ip_configuration.value.allocated_ip_range
          enable_private_path_for_google_cloud_services = ip_configuration.value.enable_private_path_for_google_cloud_services

          dynamic "authorized_networks" {
            for_each = ip_configuration.value.authorized_networks != null ? [ip_configuration.value.authorized_networks] : []
            content {
              name  = authorized_networks.value.name
              value = authorized_networks.value.value
            }
          }

          dynamic "psc_config" {
            for_each = ip_configuration.value.psc_config != null ? [ip_configuration.value.psc_config] : []
            content {
              psc_enabled               = psc_config.value.psc_enabled
              allowed_consumer_projects = psc_config.value.allowed_consumer_projects
            }
          }
        }
      }

      dynamic "location_preference" {
        for_each = settings.value.location_preference != null ? [settings.value.location_preference] : []
        content {
          follow_gae_application = location_preference.value.follow_gae_application
          zone                   = location_preference.value.zone
          secondary_zone         = location_preference.value.secondary_zone
        }
      }

      dynamic "maintenance_window" {
        for_each = settings.value.maintenance_window != null ? [settings.value.maintenance_window] : []
        content {
          day          = maintenance_window.value.day
          hour         = maintenance_window.value.hour
          update_track = maintenance_window.value.update_track
        }
      }

      dynamic "insights_config" {
        for_each = settings.value.insights_config != null ? [settings.value.insights_config] : []
        content {
          query_insights_enabled  = insights_config.value.query_insights_enabled
          query_string_length     = insights_config.value.query_string_length
          record_application_tags = insights_config.value.record_application_tags
          record_client_address   = insights_config.value.record_client_address
          query_plans_per_minute  = insights_config.value.query_plans_per_minute
        }
      }

      dynamic "password_validation_policy" {
        for_each = settings.value.password_validation_policy != null ? [settings.value.password_validation_policy] : []
        content {
          min_length                  = password_validation_policy.value.min_length
          complexity                  = password_validation_policy.value.complexity
          reuse_interval              = password_validation_policy.value.reuse_interval
          disallow_username_substring = password_validation_policy.value.disallow_username_substring
          password_change_interval    = password_validation_policy.value.password_change_interval
          enable_password_policy      = password_validation_policy.value.enable_password_policy
        }
      }
    }
  }

  database_version     = var.database_version
  name                 = var.name
  maintenance_version  = var.maintenance_version
  master_instance_name = var.master_instance_name
  project              = var.project_id

  dynamic "replica_configuration" {
    for_each = var.replica_configuration != null ? [var.replica_configuration] : []
    content {
      ca_certificate            = replica_configuration.value.ca_certificate
      client_certificate        = replica_configuration.value.client_certificate
      client_key                = replica_configuration.value.client_key
      connect_retry_interval    = replica_configuration.value.connect_retry_interval
      dump_file_path            = replica_configuration.value.dump_file_path
      failover_target           = replica_configuration.value.failover_target
      master_heartbeat_period   = replica_configuration.value.master_heartbeat_period
      password                  = replica_configuration.value.password
      ssl_cipher                = replica_configuration.value.ssl_cipher
      username                  = replica_configuration.value.username
      verify_server_certificate = replica_configuration.value.verify_server_certificate
    }
  }

  root_password       = var.root_password
  encryption_key_name = var.encryption_key_name
  deletion_protection = var.deletion_protection

  dynamic "restore_backup_context" {
    for_each = var.restore_backup_context != null ? [var.restore_backup_context] : []
    content {
      backup_run_id = restore_backup_context.value.backup_id
      instance_id   = restore_backup_context.value.instance_id
      project       = restore_backup_context.value.project
    }
  }

  dynamic "clone" {
    for_each = var.clone != null ? [var.clone] : []
    content {
      source_instance_name = clone.value.source_instance_name
      point_in_time        = clone.value.point_in_time
      database_names       = clone.value.database_names
      allocated_ip_range   = clone.value.allocated_ip_range
    }
  }

  lifecycle {

    /* precondition {
      condition     = var.replica_configuration != null && var.master_instance_name != null
      error_message = "master_instance_name must be set when replica_configuration is set"
    } */
  }
}
