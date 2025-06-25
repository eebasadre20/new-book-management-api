terraform {
  backend "s3" {
    bucket                  = "<<PLACEHOLDER>>"
    key                     = "base-source-production/terraform.tfstate"
    region                  = "ap-northeast-1"
  }
}