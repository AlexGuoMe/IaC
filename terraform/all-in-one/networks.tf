provider "aws" {
    region = "${var.AWS_REGION}"
}

# Create VPC
module "prod_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.VPC_NAME}"

  cidr = "${var.VPC_CIDR}"
  secondary_cidr_blocks = "${var.VPC_SECONDARY_CIDR}"

  azs             = "${var.AZS}"
  public_subnets  = "${var.PUBLIC_SUBNETS}"

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform = "true"
  }
}
