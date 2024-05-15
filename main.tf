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

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam-role" {
  name               = "iam-role-lambda-api-gateway"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "lambda-function" {
  filename      = "${path.module}/src.zip"
  function_name = var.lambda_name
  role          = aws_iam_role.iam-role.arn
  handler       = "src.lambda_handler"
  runtime       = "python3.9"
}