
variable "server_port" {
  description = "the port the server will use for http requests"
  default     = 8080
}

variable "cluster_name" {
  description = "the name of to use for cluster resources"
}

variable "db_remote_state_bucket" {
  description = "the name of the s3 bucket for database remote state"
}

variable "db_remote_state_key" {
  description = "the path for the databases remote state in s3"
}
