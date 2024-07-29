variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "customer_name" {
  type    = string
  default = "Demo Customer"
}

variable "environment" {
  type    = string
  default = "Dev"
}

variable "project" {
  type    = string
  default = "Demo Project"
}

variable "vpc_name" {
  type    = string
  default = "Demo-vpc"
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "The availability zones for the subnets"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}