locals {
  aws_region = var.aws_region

  tags = {
    CreatedBy    = "Terraform"
    CustomerName = var.customer_name
    Environment  = var.environment
    Project      = var.project
  }
}
