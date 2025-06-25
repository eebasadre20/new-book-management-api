terraform {
  backend "s3" {
    bucket                  = "<<PLACEHOLDER>>"
    key                     = "base-source-development/terraform.tfstate"
    region                  = "ap-northeast-1"
  }
}