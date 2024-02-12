#terraform {
#  backend "s3" {
#    bucket         = "mahjong.terraform.state"
#    key            = "common"
#    region         = "ap-northeast-1"
#    dynamodb_table = "mahjong-terraform-lock"
#  }
#  required_providers {
#    aws = "~>4.0"
#  }
#}

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
