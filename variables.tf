variable "tag_owner" {
  description = "E-mail id of the owner"
  type = string
}

variable "tag_bucket_environment" {
  type = string
  description = "Environment details"
}

variable "tag_bucket_name" {
  type = string
  description = "Unique name for the bucket"
}