provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "example" {
    ami           = "ami-0442104f148cf6b7e"
    instance_type = "t2.micro"
    key_name = "root"
    vpc_security_group_ids = [aws_security_group.terraform_demo.id]
    tags = {
        Name = "terraform demo"
    }
    user_data = <<EOF
#! /bin/bash
echo "Hello World" > index.html
nohup busybox httpd -f -p 8080 &
EOF
}

resource "aws_security_group" "terraform_demo" {
    name        = "terraform demo"
    description = "Allow 8080 inbound traffic"
    ingress {
        description      = "TLS from VPC"
        from_port        = 8080
        to_port          = 8080
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
