locals {
  os = data.external.os.result.os
  check = local.os == "Windows" ? "Windows" : "Linux"
}