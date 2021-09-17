output "public_hostnames" {
  value       = module.devBox.ec2_instances
  depends_on  = [module.devBox.ec2_instances]
  description = "EC2 public hostname"
}

output "security_group_name"{
  value = module.initialization.security_group_name
  description = "EC2 SG"
}

output "key_pair_name"{
  value = module.initialization.key_pair_name
  description = "EC2 ssh key name"
}

output "random_string"{
  value = module.initialization.key_pair_name
  description = "EC2 ssh key name"
}

output "ssh_key_path_linux"{
  value = module.initialization.ssh_key_path_linux
  description = "EC2 ssh key path for Linux"
}

output "ssh_key_path_windows"{
  value = module.initialization.ssh_key_path_windows
  description = "EC2 ssh key path for Windows"
}

output "ssh_command"{
  value = "ssh -i ${module.initialization.ssh_key_path_windows} ec2-user@${module.devBox.ec2_instances[0]}"
  description = "EC2 ssh key path for Windows"
}


