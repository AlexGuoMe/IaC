provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "example" {
    ami           = "ami-0092151d82fa94bfc"
    instance_type = "t2.micro"
    tags = {
        Name = "terraform demo"
    }
}

