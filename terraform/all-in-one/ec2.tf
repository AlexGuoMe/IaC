# Import ops ssh key
resource "aws_key_pair" "ops" {
  key_name   = "${var.SSH_KEY_NAME}"
  public_key = "${var.SSH_KEY_PUBLIC_STRING}"
}

# Generate elastic IP 
resource "aws_eip" "ins_eip" {

  # Eip count number is same as instance count number
  count = "${var.INS_COUNT}"
  vpc = true
}

# Random subnet id
resource "random_shuffle" "az" {
  # input        = ["us-west-1a", "us-west-1c", "us-west-1d", "us-west-1e"]
  input        = module.prod_vpc.public_subnets

  result_count = 1
}

# Run ec2
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "${var.INS_NAME}"

  count = "${var.INS_COUNT}"
  ami                    = "${var.AMI_NAME}"
  instance_type          = "${var.INS_TYPE}"
  key_name               = "${var.SSH_KEY_NAME}"
  vpc_security_group_ids = "${var.INS_ROLE}" == "kiss" ? [
    module.ssh_security_group.security_group_id,
    module.kiss-sg.security_group_id,
    module.allow-local-vpc.security_group_id,
  ] : [
    module.ssh_security_group.security_group_id,
    module.coturn-sg.security_group_id,
    module.allow-local-vpc.security_group_id,
  ]
  # subnet_id              = "${element(module.prod_vpc.public_subnets, 0)}"
  subnet_id              = join(",", "${random_shuffle.az.result}")
  tags = {
    Terraform   = "true"
  }
}

# Associate EIP
resource "aws_eip_association" "eip_assoc" {
  count = "${var.INS_COUNT}"
  instance_id   = element(module.ec2_instance, count.index).id
  allocation_id = element(aws_eip.ins_eip, count.index).id
}
