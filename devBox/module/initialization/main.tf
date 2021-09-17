# Gathering account info for metadata
data "aws_caller_identity" "current" {}



# Generate random password used for generating unique SSH keys
resource "random_string" "random" {
  length           = 32
  min_lower        = 8
  min_numeric      = 8
  special          = false
}

# Generate local SSH key
resource "null_resource" "run_script" {

  provisioner "local-exec" {
    command ="${local.check}"== "Linux" ? "./${path.module}/script/keygen/ssh_keygen.sh ${random_string.random.result} ${data.aws_caller_identity.current.arn} ${var.key_pair_name} " : "./script/keygen/ssh_keygen.bat"
    
  }
}

# Read local file
data "local_file" "read" {
    depends_on = [null_resource.run_script]
    filename = "${local.check}"== "Linux" ?  pathexpand("~/.ssh/${var.key_pair_name}.pub")  : "WINDOWS_PATH_NEEDED"
}

# Deploy key
resource "aws_key_pair" "deployer" {
  key_name   = "${var.key_pair_name}"
  public_key = trimspace(data.local_file.read.content)
}


# Get IP address - could script it as local script however it becomes problematic for windows vs linux
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

# Create security group based on public IP
resource "aws_security_group" "all_traffic" {
  name        = "${var.security_group_name}"
  description = "Allow inbound traffic to specific IP "
  depends_on  = [data.http.myip]

  ingress = [
    {
      description      = "All traffic"
      from_port        = 0
      to_port          = 0
      description      = "Allow all traffic to the public IP address of the following ARN(${data.aws_caller_identity.current.arn}) ID"
      protocol         = "-1"
      security_group_id= "${var.security_group_id}"
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      description=null
      prefix_list_ids=null
      security_groups=null
      self=null
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  tags = {
    Name = "SG from (${data.aws_caller_identity.current.arn})"
  }
}

