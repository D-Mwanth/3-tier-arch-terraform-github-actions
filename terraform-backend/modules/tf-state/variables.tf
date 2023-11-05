# declare variable needed in modules in this dir
variable "bucket_name" {
  description = "Remote S3 Bucket Name"
  type        = string
  validation {
    condition     = can(regex("^([a-z0-9-]{1}[a-z0-9-]{1,61}[a-z0-9-]{1})$", var.bucket_name))
    error_message = "bucket name must not be empty and must follow s3 naming convention"
  }
}