provider "aws" {
    region = "${var.AWS_REGION}"
}

provider "aws" {
  alias  = "peer"
  region = "us-east-1"

  # Accepter's credentials.
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

# Create VPC peering
resource "aws_vpc_peering_connection" "local2usEast1" {
  peer_vpc_id   = "${var.REMOTE_VPC_ID}"
  vpc_id        = module.prod_vpc.vpc_id
  peer_region   = "us-east-1"
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.local2usEast1.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

# Create route table rules for peering connection
resource "aws_route" "local_site" {
  route_table_id            = element(module.prod_vpc.public_route_table_ids, 1)

  # define us-east-1 vpc cidr, should not alter
  destination_cidr_block    = "10.120.0.0/16" 
  vpc_peering_connection_id = aws_vpc_peering_connection.local2usEast1.id
}

resource "aws_route" "remote_site" {
  provider                  = aws.peer
  # us-east-1 route table ID, should not be alter
  route_table_id            = "rtb-0703e28f45dcdb329"

  # local vpc cidr
  destination_cidr_block    = module.prod_vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.local2usEast1.id
}
