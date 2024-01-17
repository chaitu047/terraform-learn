data "aws_vpc" "selected" {
  default = false
}

data "aws_security_group" "selected" {
  id = "sg-09958aae927b9611c"
}

data "aws_subnet" "public" {
  id = "subnet-0eaad7feee733697b"
}

resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = "t3.micro"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  subnet_id              = data.aws_subnet.public.id
  tags = {
    Name = "HelloWorld"
  }
}
