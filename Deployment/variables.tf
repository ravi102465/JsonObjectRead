variable "location" {
  type    = string
  default = "westindia"
}

variable "resource_group_name_prefix" {
  type    = string
  default = "test"
}


variable "sql_administrator_login" {
  type = string
}

variable "sql_administrator_login_password" {
  type = string
}

locals {
  env_name                    = lower(terraform.workspace)
  service_name                = "test"
  front_web_app_name                = "${local.service_name}-${local.env_name}-front-webapp"
  application_web_app_name          = "${local.service_name}-${local.env_name}-app-webapp"
  tags = {
    environment      = local.env_name
  }
}
