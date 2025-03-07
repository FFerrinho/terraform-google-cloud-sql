## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.83.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.24.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [random_string.main](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_charset"></a> [charset](#input\_charset) | The charset of the database. | `string` | `"utf8"` | no |
| <a name="input_clone"></a> [clone](#input\_clone) | The clone configuration. | <pre>object({<br>    source_instance_name = optional(string)<br>    point_in_time        = optional(string)<br>    database_names       = optional(list(string))<br>    allocated_ip_range   = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | The collation of the database. | `string` | `null` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The database engine version to use. Format: [ENGINE]\_[VERSION] (e.g. MYSQL\_8\_0, POSTGRES\_14). See https://cloud.google.com/sql/docs/db-versions for supported versions. | `string` | n/a | yes |
| <a name="input_deletion_policy"></a> [deletion\_policy](#input\_deletion\_policy) | The database deletion policy. | `string` | `"NEVER"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If true, the instance cannot be deleted without disabling deletion protection. | `bool` | `false` | no |
| <a name="input_encryption_key_name"></a> [encryption\_key\_name](#input\_encryption\_key\_name) | The full path to the encryption key used for the CMEK disk encryption. | `string` | `null` | no |
| <a name="input_maintenance_version"></a> [maintenance\_version](#input\_maintenance\_version) | The maintenance version to use. | `string` | `null` | no |
| <a name="input_master_instance_name"></a> [master\_instance\_name](#input\_master\_instance\_name) | The name of the instance that will act as master in the replication setup. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the database instance and database. Must be unique within the project. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The region of the Cloud SQL instance. | `string` | n/a | yes |
| <a name="input_replica_configuration"></a> [replica\_configuration](#input\_replica\_configuration) | The configuration for replication. | <pre>object({<br>    ca_certificate            = optional(string)<br>    client_certificate        = optional(string)<br>    client_key                = optional(string)<br>    connect_retry_interval    = optional(number)<br>    dump_file_path            = optional(string)<br>    failover_target           = optional(bool)<br>    master_heartbeat_period   = optional(number)<br>    password                  = optional(string)<br>    ssl_cipher                = optional(string)<br>    username                  = optional(string)<br>    verify_server_certificate = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_restore_backup_context"></a> [restore\_backup\_context](#input\_restore\_backup\_context) | The backup context to restore from. | <pre>object({<br>    backup_id   = string<br>    instance_id = optional(string)<br>    project     = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_root_password"></a> [root\_password](#input\_root\_password) | The password for the root user. | `string` | `null` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Complete configuration for the Cloud SQL instance. See https://cloud.google.com/sql/docs/mysql/admin-api/rest/v1beta4/instances for all options. | <pre>object({<br>    tier                        = string<br>    edition                     = optional(string)<br>    user_labels                 = optional(map(string))<br>    activation_policy           = optional(string)<br>    availability_type           = optional(string)<br>    collation                   = optional(string)<br>    connector_enforcement       = optional(bool)<br>    deletion_protection_enabled = optional(bool)<br>    disk_autoresize             = optional(bool)<br>    disk_autoresize_limit       = optional(number)<br>    disk_size                   = optional(number)<br>    disk_type                   = optional(string)<br>    pricing_plan                = optional(string)<br>    time_zone                   = optional(string)<br>    advanced_machine_features = optional(object({<br>      threads_per_core = optional(number)<br>    }))<br>    database_flags = optional(list(object({<br>      name  = string<br>      value = string<br>    })))<br>    active_directory_config = optional(object({<br>      domain = optional(string)<br>    }))<br>    data_cache_config = optional(object({<br>      data_cache_enabled = optional(bool)<br>    }))<br>    deny_maintenance_period = optional(object({<br>      end_date   = optional(string)<br>      start_date = optional(string)<br>      time       = optional(string)<br>    }))<br>    sql_server_audit_config = optional(object({<br>      bucket             = optional(string)<br>      upload_interval    = optional(string)<br>      retention_interval = optional(string)<br>    }))<br>    backup_configuration = optional(object({<br>      binary_log_enabled             = optional(bool)<br>      enabled                        = optional(bool)<br>      start_time                     = optional(string)<br>      point_in_time_recovery_enabled = optional(bool)<br>      location                       = optional(string)<br>      transaction_log_retention_days = optional(number)<br>      backup_retention_settings = optional(object({<br>        retained_backups = optional(number)<br>        retention_unit   = optional(string)<br>      }))<br>    }))<br>    ip_configuration = optional(object({<br>      ipv4_enabled                                  = optional(bool)<br>      private_network                               = optional(string)<br>      ssl_mode                                      = optional(string)<br>      allocated_ip_range                            = optional(string)<br>      enable_private_path_for_google_cloud_services = optional(bool)<br>      authorized_networks = optional(object({<br>        name  = optional(string)<br>        value = optional(string)<br>      }))<br>      psc_config = optional(object({<br>        psc_enabled               = optional(bool)<br>        allowed_consumer_projects = optional(list(string))<br>      }))<br>    }))<br>    location_preference = optional(object({<br>      follow_gae_application = optional(string)<br>      zone                   = optional(string)<br>      secondary_zone         = optional(string)<br>    }))<br>    maintenance_window = optional(object({<br>      day          = optional(number)<br>      hour         = optional(number)<br>      update_track = optional(string)<br>    }))<br>    insights_config = optional(object({<br>      query_insights_enabled  = optional(bool)<br>      query_string_length     = optional(number)<br>      record_application_tags = optional(bool)<br>      record_client_address   = optional(bool)<br>      query_plans_per_minute  = optional(number)<br>    }))<br>    password_validation_policy = optional(object({<br>      min_length                  = optional(number)<br>      complexity                  = optional(bool)<br>      reuse_interval              = optional(number)<br>      disallow_username_substring = optional(bool)<br>      password_change_interval    = optional(number)<br>      enable_password_policy      = optional(bool)<br>    }))<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | The connection name of the Cloud SQL instance. |
| <a name="output_database_version"></a> [database\_version](#output\_database\_version) | The database engine version. |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The self\_link of the Cloud SQL instance. |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | The IP address of the Cloud SQL instance. |
| <a name="output_name"></a> [name](#output\_name) | The name of the database instance. |
| <a name="output_server_ca_cert"></a> [server\_ca\_cert](#output\_server\_ca\_cert) | The CA certificate information for client SSL verification. |
| <a name="output_settings"></a> [settings](#output\_settings) | The settings of the database instance. |
| <a name="output_sql_id"></a> [sql\_id](#output\_sql\_id) | The ID of the Cloud SQL. |
