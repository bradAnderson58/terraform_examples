
variable "user_names" {
  description = "create IAM users with these names"
  type        = "list"
  default     = ["neo", "trinity", "morpheus"]
}