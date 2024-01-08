variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = map(string)
  default = {
    master = "ami-00d8834ea9c9ecd09"
<<<<<<< HEAD
=======
    worker = "ami-00d8834ea9c9ecd09"
>>>>>>> 456cddac11ca2cb947317261adb90f308161ae70
  }
}

variable "instance_type" {
  type = map(string)
  default = {
    master = "t2.medium"
<<<<<<< HEAD
  }
=======
    worker = "t2.micro"
  }
}

variable "worker_instance_count" {
  type    = number
  default = 1
>>>>>>> 456cddac11ca2cb947317261adb90f308161ae70
}