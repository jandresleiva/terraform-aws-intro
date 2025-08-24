variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
  default = "my-d6ed7ace-3268-4cda-91ed-b20539b0e126"
}

variable "index_file" {
  description = "Path to local index.html file to upload"
  type        = string
  default     = "index.html"
}
