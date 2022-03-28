# Common Security Group
module "ssh_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 4.0"

  name        = "jumpserver"
  description = "Jumpserver"
  vpc_id      = module.prod_vpc.vpc_id
  ingress_cidr_blocks = ["10.120.0.0/16", "52.80.136.41/32"]
}

module "allow-local-vpc" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "allow-vpc-all"
  description = "all vpc all"
  vpc_id      = module.prod_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "all"
      description = "allow vpc all"
      cidr_blocks = "${var.VPC_CIDR}"
    },
  ]
}

# Kiss Security Group
module "kiss-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "kiss"
  description = "kiss rules"
  vpc_id      = module.prod_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "allow 443 public access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 17777
      to_port     = 17777
      protocol    = "tcp"
      description = "allow 17777 public access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 16666
      to_port     = 16666
      protocol    = "tcp"
      description = "allow 16666 tcp public access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 16666
      to_port     = 16666
      protocol    = "udp"
      description = "allow 16666 udp public access"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

# Corturn Security Group
module "coturn-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "coturn"
  description = "coturn rules"
  vpc_id      = module.prod_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 49152
      to_port     = 65535
      protocol    = "tcp"
      description = "allow 49152 to 65535 tcp public access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 49152
      to_port     = 65535
      protocol    = "udp"
      description = "allow 49152 to 65535 udp public access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 5349
      to_port     = 5349
      protocol    = "tcp"
      description = "allow 5349 tcp public access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 5349
      to_port     = 5349
      protocol    = "udp"
      description = "allow 5349 udp public access"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "all"
      description = "allow all 8080 access from beijing office"
      cidr_blocks = "111.200.53.82/31"
    },
  ]
}
