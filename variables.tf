### Cloud SQL

variable "name" {
  description = "The name of the database."
  type        = string
}

variable "charset" {
  description = "The charset of the database."
  type        = string
  default     = "utf8"
}

variable "collation" {
  description = "The collation of the database."
  type        = string
  default     = null
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
  default     = null
}

variable "deletion_policy" {
  description = "The database deletion policy."
  type        = string
  default     = "NEVER"
}

### Cloud SQL instance

variable "region" {
  description = "The region of the Cloud SQL instance."
  type        = string
}

variable "settings" {
  description = "The settings to use for the database instance."
  type = object({
    tier                        = string
    edition                     = optional(string)
    user_labels                 = optional(map(string))
    activation_policy           = optional(string)
    availability_type           = optional(string)
    collation                   = optional(string)
    connector_enforcement       = optional(bool)
    deletion_protection_enabled = optional(bool)
    disk_autoresize             = optional(bool)
    disk_autoresize_limit       = optional(number)
    disk_size                   = optional(number)
    disk_type                   = optional(string)
    pricing_plan                = optional(string)
    time_zone                   = optional(string)
    advanced_machine_features = optional(object({
      threads_per_core = optional(number)
    }))
    database_flags = optional(list(object({
      name  = string
      value = string
    })))
    active_directory_config = optional(object({
      domain = optional(string)
    }))
    data_cache_config = optional(object({
      data_cache_enabled = optional(bool)
    }))
    deny_maintenance_period = optional(object({
      end_date   = optional(string)
      start_date = optional(string)
      time       = optional(string)
    }))
    sql_server_audit_config = optional(object({
      bucket             = optional(string)
      upload_interval    = optional(string)
      retention_interval = optional(string)
    }))
    backup_configuration = optional(object({
      binary_log_enabled             = optional(bool)
      enabled                        = optional(bool)
      start_time                     = optional(string)
      point_in_time_recovery_enabled = optional(bool)
      location                       = optional(string)
      transaction_log_retention_days = optional(number)
      backup_retention_settings = optional(object({
        retained_backups = optional(number)
        retention_unit   = optional(string)
      }))
    }))
    ip_configuration = optional(object({
      ipv4_enabled                                  = optional(bool)
      private_network                               = optional(string)
      require_ssl                                   = optional(bool)
      allocated_ip_range                            = optional(string)
      enable_private_path_for_google_cloud_services = optional(bool)
      authorized_networks = optional(object({
        name  = optional(string)
        value = optional(string)
      }))
      psc_config = optional(object({
        psc_enabled               = optional(bool)
        allowed_consumer_projects = optional(list(string))
      }))
    }))
    location_preference = optional(object({
      follow_gae_application = optional(string)
      zone                   = optional(string)
      secondary_zone         = optional(string)
    }))
    maintenance_window = optional(object({
      day          = optional(number)
      hour         = optional(number)
      update_track = optional(string)
    }))
    insights_config = optional(object({
      query_insights_enabled  = optional(bool)
      query_string_length     = optional(number)
      record_application_tags = optional(bool)
      record_client_address   = optional(bool)
      query_plans_per_minute  = optional(number)
    }))
    password_validation_policy = optional(object({
      min_length                  = optional(number)
      complexity                  = optional(bool)
      reuse_interval              = optional(number)
      disallow_username_substring = optional(bool)
      password_change_interval    = optional(number)
      enable_password_policy      = optional(bool)
    }))
  })
  default = null

  /* validation {
    condition     = can(regex("^db-[a-z]+-[0-9]+(-[a-z]+-[0-9]+)?$", var.settings.tier))
    error_message = "The machine tier must be formatted according to the Google Cloud machine types."
  }

  validation {
    condition     = var.settings.edition != null && contains(["ENTERPRISE", "ENTERPRISE_PLUS"], var.settings.edition)
    error_message = "The edition must be one of ENTERPRISE, ENTERPRISE_PLUS."
  }

  validation {
    condition     = var.settings.activation_policy != null && contains(["ALWAYS", "NEVER", "ON_DEMAND"], var.settings.activation_policy)
    error_message = "The activation policy must be one of ALWAYS, NEVER, ON_DEMAND."
  }

  validation {
    condition     = var.settings.disk_size == null || var.settings.disk_size >= 10
    error_message = "The disk size must be at least 10GB."
  }

  validation {
    condition     = var.settings.disk_type != null && contains(["PD_SSD", "PD_HDD"], var.settings.disk_type)
    error_message = "The disk type must be one of PD_SSD, PD_HDD."
  }

  validation {
    condition     = var.settings.pricing_plan != null && contains(["PER_USE"], var.settings.pricing_plan)
    error_message = "The pricing plan must be one of PER_USE."
  }

  validation {
    condition     = can(regex("^(\\+|-)[0-9]{1,2}:[0-9]{2}|UTC$", var.settings.time_zone))
    error_message = "The time zone must be formatted according to the IANA time zone database."
  }

  validation {
    condition     = var.settings.advanced_machine_features != null && contains([1, 2], var.settings.advanced_machine_features.threads_per_core)
    error_message = "The number of threads per core must be one of 1 (to disable SMT) or 2."
  }

  validation {
    condition     = can(regex("^[0-9]+$", var.settings.insights_config.query_string_length)) && var.settings.insights_config.query_string_length >= 256 && var.settings.insights_config.query_string_length <= 4500
    error_message = "The query string length must be between 256 and 4500."
  }

  validation {
    condition     = can(regex("^[0-9]+$", var.settings.insights_config.query_plans_per_minute)) && var.settings.insights_config.query_plans_per_minute <= 20
    error_message = "The query plans per minute must be at most 20."
  } */
}

variable "database_version" {
  description = "The database version to use. Check https://cloud.google.com/sql/docs/db-versions for supported versions."
  type        = string

  validation {
    condition     = contains(["MYSQL_5_6", "MYSQL_5_7", "MYSQL_8_0", "POSTGRES_9_6", "POSTGRES_10", "POSTGRES_11", "POSTGRES_12", "POSTGRES_13", "POSTGRES_14", "POSTGRES_15", "SQLSERVER_2017_STANDARD", "SQLSERVER_2017_ENTERPRISE", "SQLSERVER_2017_EXPRESS", "SQLSERVER_2017_WEB", "SQLSERVER_2019_STANDARD", "SQLSERVER_2019_ENTERPRISE", "SQLSERVER_2019_EXPRESS", "SQLSERVER_2019_WEB"], var.database_version)
    error_message = "The database version must be one of MYSQL_5_6, MYSQL_5_7, MYSQL_8_0, POSTGRES_9_6, POSTGRES_10, POSTGRES_11, POSTGRES_12, POSTGRES_13, POSTGRES_14, POSTGRES_15, SQLSERVER_2017_STANDARD, SQLSERVER_2017_ENTERPRISE, SQLSERVER_2017_EXPRESS, SQLSERVER_2017_WEB, SQLSERVER_2019_STANDARD, SQLSERVER_2019_ENTERPRISE, SQLSERVER_2019_EXPRESS, SQLSERVER_2019_WEB."
  }
}

variable "maintenance_version" {
  description = "The maintenance version to use."
  type        = string
  default     = null
}

variable "master_instance_name" {
  description = "The name of the instance that will act as master in the replication setup."
  type        = string
  default     = null
}

variable "replica_configuration" {
  description = "The configuration for replication."
  type = object({
    ca_certificate            = optional(string)
    client_certificate        = optional(string)
    client_key                = optional(string)
    connect_retry_interval    = optional(number)
    dump_file_path            = optional(string)
    failover_target           = optional(bool)
    master_heartbeat_period   = optional(number)
    password                  = optional(string)
    ssl_cipher                = optional(string)
    username                  = optional(string)
    verify_server_certificate = optional(bool)
  })
  default = null
}

variable "root_password" {
  description = "The password for the root user."
  type        = string
  default     = null
}

variable "encryption_key_name" {
  description = "The full path to the encryption key used for the CMEK disk encryption."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "If true, the instance cannot be deleted without disabling deletion protection."
  type        = bool
  default     = false
}

variable "restore_backup_context" {
  description = "The backup context to restore from."
  type = object({
    backup_id   = string
    instance_id = optional(string)
    project     = optional(string)
  })
  default = null
}

variable "clone" {
  description = "The clone configuration."
  type = object({
    source_instance_name = optional(string)
    point_in_time        = optional(string)
    database_names       = optional(list(string))
    allocated_ip_range   = optional(string)
  })
  default = null
}
