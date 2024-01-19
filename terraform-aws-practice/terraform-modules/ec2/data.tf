data "aws_vpc" "main" {
  default = false
}

data "aws_subnet" "pub_subnet" {
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.0.0/26"
}

data "aws_ami" "centos-ami" {
  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
