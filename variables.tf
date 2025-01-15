variable "bucket_name" {
  type        = string
  default = "bucket-egorkinae-kms-2025"
  description = "Имя s3 bucket"
}
# Заменить на ID своего облака
variable "yandex_cloud_id" {
  default = "***"
}

# Заменить на Folder своего облака
variable "yandex_folder_id" {
  default = "***"
}

variable "token" {
  type        = string
  default     = "***"
  sensitive   = true
  # https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}
