terraform {
  backend "s3" {
    bucket         = "mahjong.terraform.state"
    key            = "common"
    region         = "ap-northeast-1"
  }
  required_providers {
    aws = "~>4.0"
  }
}

provider "aws" {
  default_tags {
    tags = {
      cost    = "mahjong"
    }
  }
}

module "tfstate_bucket" {
  source = "../modules/s3"

  bucket_name = "mahjong.terraform.state"
}

module "apigw_account" {
  source = "../modules/apigateway-account"
}

# dev・prod共通のECRを使用する
module "mahjong_gateway_ecr" {
  source = "../modules/ecr"

  ecr_name = var.mahjong_gateway_ecr.name
}
