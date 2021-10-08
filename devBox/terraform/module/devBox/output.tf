output "ec2_instances"{
    value = aws_instance.ec2_instances.*.public_dns
    description = "EC2 public Hostname"
}


