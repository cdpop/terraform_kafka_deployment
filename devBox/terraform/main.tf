provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

# Initialize creates the ssh key and SG for EC2
module "initialization"{
  source  = "./module/initialization"
  key_pair_name = var.key_pair_name
  security_group_name = var.security_group_name
  owner_email = var.owner_email  
}

# Deployin EC2 instance
module "devBox" {
  source = "./module/devBox"
  depends_on = [module.initialization]
  # Defining EC2
  ami              = var.ami
  type_instance    = var.type_instance
  key              = module.initialization.key_pair_name
  root_volume_size = 100
  instances        = 1
  ec2-name         = var.ec2_name
  security_group   = module.initialization.security_group_name
  owner_email      = var.owner_email

  # Install Script
  user                  = var.user
  ssh_key_path          = pathexpand(module.initialization.ssh_key_path_linux)
  provision_script_src  = "scripts"
  provision_script_dest = "/tmp"
  script_command        = "/tmp/scripts/exec/${var.shell_script_name}"
}

# Fix .ssh/config file to include proper hostname
module "post_initialization"{
  source  = "./module/post_initialization"
  
  public_hostname = module.devBox.ec2_instances[0]
}

# Delete the old SSH keys and remove .ssh/config addition
module "cleanup" {
  source = "./module/cleanup"
  depends_on = [module.initialization, module.devBox]
  public_hostname = module.devBox.ec2_instances[0]
  os = module.initialization.os
  key_pair_name = var.key_pair_name
  random_string = module.initialization.random_string  
}
