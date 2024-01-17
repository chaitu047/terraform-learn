data "aws_vpc" "selected" {
  filter {
    name   = "Name"
    values = ["dev-vpc"]
  }
}
