module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.9.0"


  name = var.vpc_name
  cidr = var.cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = merge(
    local.tags,
    {
      Name = "demo-vpc"
    }
  )
}
