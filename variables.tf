variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-2"
}


variable "key_name" {
  description = "Name of the existing EC2 key pair"
  default = "2024"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for remote state"
  default = "aknb1"
}

variable "lambda_name" {
  description = "Name of the lambda"
  default = "aknlambda"
}

variable "name" {
  description = "Name of EC2 Intance"
}