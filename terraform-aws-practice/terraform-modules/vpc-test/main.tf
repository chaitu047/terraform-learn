module "vpc-test" {
  source       = "../vpc"
  environment  = "dev"
  project_name = "roboshop"
  common_tags = {
    Terraform = "True"
  }

  vpc_tags = {
    VPC = "CustomVPC"
  }

  igw_tags = {
    IGW = "True"
  }

  ngw_tags = {
    NGW = "True"
  }
}
