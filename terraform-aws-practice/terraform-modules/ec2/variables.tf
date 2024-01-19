variable "instance_type" {
  type = string
}

variable "az_name" {
  type = string
}

variable "ec2_tags" {
  type    = map(any)
  default = {}
}

variable "common_tags" {
  type    = map(any)
  default = {}
}

variable "sg_tags" {
  type    = map(any)
  default = {}
}

variable "env_name" {
  type = string
}
