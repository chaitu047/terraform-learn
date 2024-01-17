resource "aws_instance" "web" {
  ami               = var.ami_id
  instance_type     = "t3.micro"
  availability_zone = "us-east-1a"
  tags = {
    Name = "HelloWorld"
  }
}