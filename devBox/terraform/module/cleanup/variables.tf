variable "public_hostname"{
  type = string
  description = "EC2 public hostname"
}

variable "random_string"{
  type = string
  description = "Random string generated from initialization"
}

variable "os"{
  type = string
  description = "OS"
}

variable "key_pair_name"{
  type = string
  description = "EC2 key pair name"
}