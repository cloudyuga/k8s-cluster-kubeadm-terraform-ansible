variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = map(string)
  default = {
    master = "ami-00d8834ea9c9ecd09"
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    master = "t2.medium"
  }
}