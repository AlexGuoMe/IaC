####################### Instance role: corturn or coturn? #########
variable "INS_ROLE" {
    default = "coturn"
}
####################### Instance tags   ########################
variable "ENVIRONMENT" {
    default = "staging-eu"
}

####################### VPC peering related ####################
variable "REMOTE_VPC_ID" {
    default = "vpc-0d5678336a1680b98"
}

####################### Network related ########################
variable "AWS_REGION" {    
    default = "eu-south-1"
}

variable "VPC_NAME" {    
    default = "eu-south-1-vpc"
}

variable "VPC_CIDR" {    
    default = "10.203.0.0/16"
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
  default = ["10.203.1.0/24", "10.203.2.0/24", "10.203.3.0/24"]
}

######################## EC2 related #############################
variable "INS_NAME" {    
    default = "coturn-test"
}

variable "INS_COUNT" {    
    default = 1
}

# AMI should be copied to target available region first
variable "AMI_NAME" {    
    default = "ami-0ce5ff637db2e9833"
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

# user-data related user-data中的脚本需要手动copy到ec2.tf中的相关位置 
variable "COTURN_USER_DATA" {
    default = "coturn"

#   user_data = <<EOF
# #! /bin/bash
# mkdir /home/ops/coturn && cd /home/ops/coturn && s3cmd get s3://addx-devops/auto-deploy/coturn/coturn.zip && unzip coturn.zip
# environment=`curl http://169.254.169.254/latest/meta-data/tags/instance/environment`
# cd /home/ops/coturn/init && chmod +x ec2_init.sh
# bash ec2_init.sh $environment &> /tmp/coturn_init.log
# cd /home/ops/coturn/init/script && chmod +x coturn_deploy.sh
# bash coturn_deploy.sh $environment &> /tmp/coturn_deploy.log
# EOF
  
}

variable "KISS_USER_DATA" {
    default = "kiss"
#   user_data = <<EOF
# #! /bin/bash
# mkdir /home/ops/kiss && cd /home/ops/kiss && s3cmd get s3://addx-devops/auto-deploy/kiss/kiss.zip && unzip kiss.zip
# environment=`curl http://169.254.169.254/latest/meta-data/tags/instance/environment`
# cd /home/ops/kiss/init && chmod +x ec2_init.sh
# bash ec2_init.sh $environment &> /tmp/kiss_init.log
# cd /home/ops/kiss/init/script && chmod +x kiss_deploy.sh
# bash kiss_deploy.sh $environment &> /tmp/kiss_deploy.log
# EOF
}
