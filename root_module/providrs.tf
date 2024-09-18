

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      "Managemet by" = "Terraform"
    }
  }
  profile = "terraform"
  region  = "ap-southeast-1"
}

