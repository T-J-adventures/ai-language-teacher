terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}

data "archive_file" "hello_lambda_zip_source" {
  type        = "zip"
  source_dir  = "${path.module}/../source/"
  output_path = "${path.module}/dist/hello_lambda.zip"
}

module "create_hello_lambda" {
  source = "./modules/rest-with-lambda"

  lambda_prefix = "Joe_Hello"
  lambda_file_path = "${path.module}/dist/hello_lambda.zip"
}

resource "local_file" "templates" {
    for_each = fileset(path.module, "templates/**")

    content = templatefile(each.key, {
        hello_lambda_url = module.create_hello_lambda.lambda_url
    })
    
    filename = replace("${path.module}/${each.key}", "templates", "dist/config")
}

