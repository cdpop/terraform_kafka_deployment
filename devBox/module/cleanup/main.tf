# need to remove previous keys on destroy of env and remove the .ssh/config items as well
resource "null_resource" "clean_local" {
  triggers = {
    public_hostname                  = var.public_hostname
    random_string                    = var.random_string
    os                               = var.os
    key_pair_name                    = var.key_pair_name
  }

  provisioner "local-exec" {
    when = destroy
    command ="${self.triggers.os}"== "Linux" ? "./${path.module}/scripts/remove_ssh.sh ${self.triggers.public_hostname} ${self.triggers.random_string} ${self.triggers.key_pair_name}" : "./script/remove_ssh.bat"
    
  }
}