resource "aws_instance" "ec2_instances" {
  ami   = var.ami
  count = var.instances

  instance_type   = var.type_instance
  key_name        = var.key
  security_groups = ["${var.security_group}"]


  connection {
    type        = "ssh"
    agent       = "false"
    user        = "${var.user}"
    host        = self.public_dns
    private_key = "${file("${var.ssh_key_path}")}"
  }

  #coping script
  provisioner "file" {
    source      = "${var.provision_script_src}"
    destination = "${var.provision_script_dest}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x -R ${var.provision_script_dest}/${var.provision_script_src}",
      "sudo  ${var.script_command} "
    ]
  }
  

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name = var.ec2-name
    owner_email = var.owner_email
  }

  timeouts {
    create = "25m"

  }
}








