# need to fix local .ssh/config file


resource "null_resource" "run_script" {

  provisioner "local-exec" {
    command ="${local.check}"== "Linux" ? "./${path.module}/script/keygen/ssh_keygen_hostname_replacement.sh ${var.public_hostname}" : "SET_WINDOWS_PATH"
    
  }
}









