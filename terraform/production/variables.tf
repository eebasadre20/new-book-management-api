///////////////////////////////////////////////////////////////////////////
# Need to get the credential from AWS SSM
///////////////////////////////////////////////////////////////////////////

variable "database_password" {
  description = "Name of database password"
}

variable "github_token" {
  description = "Github personal access token"
}

variable "docker_username" {
  description = "Docker Username"
}

variable "docker_password" {
  description = "Docker Password"
}

variable "rollbar_token" {
  description = "Basic auth username"
}

variable "ses_secret_key" {
  description = "AWS Secret Key for SES "
}

variable "ses_api_key" {
  description = "AWS Secret ID for SES"
}

variable "ses_region" {
  description = "AWS Region for SES"
}

variable "s3_secret_key" {
  description = "AWS Secret Key for SES "
}

variable "s3_api_key" {
  description = "AWS Secret ID for SES"
}
///////////////////////////////////////////////////////////////////////////
# Please update default values if needed
///////////////////////////////////////////////////////////////////////////

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "base_source_production"
}

variable "env" {
  description = "Environment that is used as placeholder"
  default     = "production"
}

variable "azs" {
  description = "A list of availability zones in the region"
  default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

# IP architecture
# https://www.notion.so/iruuzainc/IP-architecture-85d035693086447c88fcf286f682d21b

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overriden"
  default     = "10.20.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  default     = ["10.20.128.0/24", "10.20.129.0/24"]
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  default     = ["10.20.192.0/26", "10.20.192.64/26"]
}

variable "elasticache_subnets" {
  description = "Elasticache Subnets"
  default     = ["10.20.193.0/26", "10.20.193.64/26"]
}


variable "database_name" {
  description = "Name of database name"
  default     = "base_source_production"
}

variable "database_user" {
  description = "Name of database user"
  default     = "base_source_production"
}


variable "instance_class" {
  description = "Database instance type"
  instance_class = "db.t3.small"
}



variable "lb_healthcheck_path" {
  description = "Path of loadbalancer's health check"
  default     = "/health"
}

variable "github_account" {
  description = "Github account name of access token"
  default     = "Jitera"
}

variable "github_repository" {
  description = "Github repository to get source"
  default     = "<<PLACEHOLDER>>"
}

variable "github_branch" {
  description = "Git branch to get source"
  default     = "master"
}

variable "zone_id" {
  description = "Zone ID"
  default     = "<<PLACEHOLDER>>"
}

variable "domain" {
  description = "Domain"
  default     = "base-source-production.project.jitera.app"
}

variable "slack_channel_id" {
  description = "Slack Channel identifier"
  default     = ""
}

variable "slack_workspace_id" {
  description = "Slack Workspace identifier"
  default     = "<<PLACEHOLDER>>"
}

variable "notify_slack_webhook_url" {
  description = "Slack Webhook for Cloudwatch notification"
  default     = "<<PLACEHOLDER>>"
}

variable "notify_slack_channel" {
  description = "Slack channel for Cloudwatch notification"
  default     = "<<PLACEHOLDER>>"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  default     = "<<PLACEHOLDER>>"
}

# s3 storage bucket
variable "iam_user_name" {
  default = "s3-production-user"
}

variable "bucket_name" {
  default = "base-source-production-storage"
}

variable "country_code" {
  description = "The list of restricted country"
  default     = []
}

#Only use this one when both FE & BE use the same slack channel
variable "sns_target_arn" {
  description = "Amazon SNS topic"
  default     = ""
}

# Example: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
# db.t3.small: 150 connections, db.t3.medium: 500 connections 
# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
variable "database_max_connections" { 
  description = "Maximum number of connections"
  default     = "150"
}
