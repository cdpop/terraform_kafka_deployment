variable "instances" {
  type = number
  description = "Number of instances"
  default = 1
}

variable "type_instance" {
  type = string
  description = "EC2 instance type ex: t2.nano"
  default = "t2.micro"
}

variable "ami" {
  type = string
  description = "EC2 AMI"
}

variable "key" {
  type = string
  description = "SSH-key attached to EC2 instance"
}

variable "ec2-name" {
  type = string
  description = "EC2 instance name"
}

variable "root_volume_size" {
  type = number
  description = "Root volume size on the EC2 instance"
}


variable "security_group" {
  type = string
  description = "Security group for EC2 instance"
  default = "default"
  
}

variable "user" {
    type = string
    description = "User for provisioner. "
}

variable "ssh_key_path" {
  type = string
  description = "Private Key path for provisioner."
}

variable "provision_script_src" {
  type = string
  description = "Provisioner SRC script"
}

variable "provision_script_dest" {
  type = string
  description = "Provisioner DEST script"
}

variable "script_command" {
    type = string
    description = "Runs sudo on the file that we pass along and we can pass in any args"
    default = ""
  
}












