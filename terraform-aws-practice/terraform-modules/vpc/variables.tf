variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cidr_block" {
  type    = string
  default = "172.16.0.0/16"
}

variable "pub_subnets" {
  type    = list
  default = ["172.16.0.0/24", "172.16.1.0/24"]
}

variable "private_subnets" {
  type    = list
  default = ["172.16.2.0/24", "172.16.3.0/24"]
}

variable "db_subnets" {
  type    = list
  default = ["172.16.4.0/24", "172.16.5.0/24"]
}

variable "common_tags" {
  type    = map
  default = {}
}

variable "vpc_tags" {
  type    = map
  default = {}
}

variable "igw_tags" {
  type    = map
  default = {}
}

variable "ngw_tags" {
  type    = map
  default = {}
}
