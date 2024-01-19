resource "aws_ssm_parameter" "vpc_id" {
  name  = "/terraform/${var.env_name}/vpc_id"
  type  = "String"
  value = data.aws_vpc.main.id
}

resource "aws_ssm_parameter" "vpc_security_group_id" {
  name  = "/terraform/${var.env_name}/vpc_security_group_id"
  type  = "String"
  value = aws_security_group.allow_tls.id
}

resource "aws_ssm_parameter" "pub_subnet_id" {
  name  = "/terraform/${var.env_name}/pub_subnet_id"
  type  = "String"
  value = data.aws_subnet.pub_subnet.id
}
