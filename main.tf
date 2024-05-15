terraform {
  backend "s3" {
    bucket         = "aknb2"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-01"
  }
}

provider "aws" {
  region = var.aws_region
}


resource "aws_lambda_function" "lambda-function" {
  filename      = "${path.module}/src"
  function_name = var.lambda_name
  role          = aws_iam_role.iam-role.arn
  handler       = "src.lambda_handler"
  runtime       = "python3.9"
}