terraform {
  backend "s3" {
    bucket                  = "<<PLACEHOLDER>>"
    key                     = "base-source-staging/terraform.tfstate"
    region                  = "ap-northeast-1"
  }
}