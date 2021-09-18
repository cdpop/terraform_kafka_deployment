variable "aws_region"{
    type = string
    description = "AWS Region to deploy to"
    default = "us-east-1"
}

# variable "aws_secret_access_key"{
#     type = string
#     description = "AWS Secret Access Key"
# }

# variable "aws_access_key_id"{
#     type = string
#     description = "AWS Access key"
# }

variable "key_pair_name"{
    type = string
    description = "Name of EC2 ssh key which gets deployed and saved in the store"
}

variable "security_group_name"{
    type = string
    description = "SG name in AWS"
}


variable "ec2_name"{
    type = string
    description = "SG name in AWS"
}

variable "user"{
    type = string
    description = "Use used for running initialization scripts"
    default = "ec2-user"
}

variable "ami"{
    type = string
    description = "AMI from AWS"
}

variable "type_instance"{
    type = string
    description = "AWS Instance Type"
    default = "t3a.xlarge"
}


variable "shell_script_name"{
    type = string
    description = "Name of the shell script to be executed from /tmp/scripts/exec"
    default = "vincents_demo"
}
