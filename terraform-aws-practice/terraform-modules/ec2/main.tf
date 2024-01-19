resource "aws_instance" "web" {
  ami                    = data.aws_ami.centos-ami.id
  instance_type          = var.instance_type
  availability_zone      = var.az_name
  vpc_security_group_ids = [aws_ssm_parameter.vpc_security_group_id.value]
  subnet_id              = aws_ssm_parameter.pub_subnet_id.value
  tags                   = merge(var.common_tags, var.ec2_tags)
}
