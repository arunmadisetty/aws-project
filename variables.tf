variable "region" {
  type        = string
  default = "us-east-2"
}

variable "db_name" {
  description = "The name of the WordPress database"
  type        = string
  default = "mydb"
}

variable "db_user" {
  description = "The WordPress database user"
  type        = string
  default = "foo"
}

variable "db_password" {
  description = "The password for the WordPress database user"
  type        = string
  default = "must_be_eight_characters"
}

