variable "web_server_port" {
    description = "The port the server will use for HTTP requests"
    type = number
    default = 8080
}

# output "public_ip" {
#     description = "The public IP of web server"
#     value = aws_instance.example.public_ip
# }

provider "aws" {
    region = "eu-west-2"
}

resource "aws_launch_configuration" "example" {
    image_id      = "ami-0442104f148cf6b7e"
    instance_type = "t2.micro"
    key_name = "root"
    security_groups = [aws_security_group.terraform_demo.id]
    user_data = <<EOF
#! /bin/bash
echo "Hello World" > index.html
nohup busybox httpd -f -p ${var.web_server_port} &
EOF

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_autoscaling_group" "example" {
  availability_zones = data.aws_availability_zones.available.names
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1
  launch_configuration = aws_launch_configuration.example.name
}

# resource "aws_instance" "example" {
#     ami           = "ami-0442104f148cf6b7e"
#     instance_type = "t2.micro"
#     key_name = "root"
#     vpc_security_group_ids = [aws_security_group.terraform_demo.id]
#     tags = {
#         Name = "terraform demo"
#     }
#     user_data = <<EOF
# #! /bin/bash
# echo "Hello World" > index.html
# nohup busybox httpd -f -p ${var.web_server_port} &
# EOF
# }

resource "aws_security_group" "terraform_demo" {
    name        = "terraform demo"
    description = "Allow 8080 inbound traffic"
    ingress {
        description      = "TLS from VPC"
        from_port        = var.web_server_port
        to_port          = var.web_server_port
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
        description      = "SSH from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "ops" {
  key_name   = "ops"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC43fQIDqaOqnVEJnnAprlTv9G0x2eFXoArqCM56icaELt9bv0Q8hMGfdOTanU7WsoljDKTRbp+Km7M2duH1jp9z37ueZkhJezukNQiL4zhkeAF5buRQSWyjmIg/PtjxW5wJXyjlvZ4F00/YrrCZu+/jyMBUmGMQ0bmiZEvUeV/uZ2l1E3YgRIqaNnVzgVtFYs/8Lil4qaL8RranQ+xclp8gTOVBPxCZ6PgaXAncIxQ2ncxQVFJIDCpllyeNukUAPd7Np4L5rC7liDzC+9vavUcDtbXmbU2oN1kiureyzJ0wU/4rUxbtCleygtQnN2PuyOuKRtPygg5l3nwTDc8T2u7"
}
