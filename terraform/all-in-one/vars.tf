####################### Instance role: kiss or coturn? #########
variable "INS_ROLE" {
    default = "kiss"
}

####################### Network related ########################
variable "AWS_REGION" {    
    default = "eu-south-1"
}

variable "VPC_NAME" {    
    default = "eu-south-1-vpc"
}

variable "VPC_CIDR" {    
    default = "10.0.0.0/16"
}

variable "VPC_SECONDARY_CIDR" {    
    type    = list(string)
    default = ["192.169.0.0/16"]
}

variable "AZS" {
  type    = list(string)
  default = ["eu-south-1a", "eu-south-1b", "eu-south-1c"]
}

variable "PUBLIC_SUBNETS" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

######################## EC2 related #############################
variable "INS_NAME" {    
    default = "kiss-test"
}

variable "INS_COUNT" {    
    default = 2
}

# AMI should be copied to target available region first
variable "AMI_NAME" {    
    default = "ami-0f369737335738790"
}

variable "INS_TYPE" {    
    default = "c5.xlarge"
}

variable "SSH_KEY_NAME" {    
    default = "ops"
}

variable "SSH_KEY_PUBLIC_STRING" {    
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC43fQIDqaOqnVEJnnAprlTv9G0x2eFXoArqCM56icaELt9bv0Q8hMGfdOTanU7WsoljDKTRbp+Km7M2duH1jp9z37ueZkhJezukNQiL4zhkeAF5buRQSWyjmIg/PtjxW5wJXyjlvZ4F00/YrrCZu+/jyMBUmGMQ0bmiZEvUeV/uZ2l1E3YgRIqaNnVzgVtFYs/8Lil4qaL8RranQ+xclp8gTOVBPxCZ6PgaXAncIxQ2ncxQVFJIDCpllyeNukUAPd7Np4L5rC7liDzC+9vavUcDtbXmbU2oN1kiureyzJ0wU/4rUxbtCleygtQnN2PuyOuKRtPygg5l3nwTDc8T2u7"
}
