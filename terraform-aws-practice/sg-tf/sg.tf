resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.selected.id

  ingress = {
    cidr_ipv4   = ["0.0.0.0/0"]
    from_port   = 443
    ip_protocol = "tcp"
    to_port     = 443
  }

  egress = {
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "-1"
  }

  tags = {
    Name = "allow_tls"
  }
}
