output "random_string" {
  value       = random_string.random.result
  description = "Random password ID used in keygen for SSH and naming of EC2 instances"
}

output "rsa_info" {
  value       = trimspace(data.local_file.read.content)
  description = "Reading local public key to be sent to AWS"
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "security_group_name"{
  value = var.security_group_name
  description = "SG name for EC2 instance"
}

output "key_pair_name"{
  value = var.key_pair_name
  description = "EC2 key pair name"
}

output "ssh_key_path_linux"{
  value = "~/.ssh/${var.key_pair_name}"
  description = "SSH key on local machine for Linux"
}

output "ssh_key_path_windows"{
  value = "~/.ssh/${var.key_pair_name}"
  description = "SSH key on local machine for Windows"
}

output "os"{
  value = data.external.os.result.os
  description = "EC2 key pair name"
}