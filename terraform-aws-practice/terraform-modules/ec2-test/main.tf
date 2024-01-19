module "ec2_test" {
  source        = "../ec2"
  env_name      = "DEV"
  az_name       = "us-east-1a"
  instance_type = "t2.micro"
  common_tags = {
    Name      = "Roboshop"
    ENV       = "DEV"
    Terraform = "True"
  }
  sg_tags = {
    AllowTLS = "True"
    AllowSSH = "True"
  }
  ec2_tags = {
    Test = "True"
  }
}
