output "base64_encoded_template" {
  value = base64encode(templatefile("../cloud-config.tpl", {
    master = var.master
  }))
}
