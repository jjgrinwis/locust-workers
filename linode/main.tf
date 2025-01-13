# Linode API token stored in env var VAR_TF_token
# export TF_VAR_linode_token="25xxx"
provider "linode" {
  token = var.linode_token
}

# using random 
provider "random" {}

# get all our regions
data "linode_regions" "filtered-regions" {
  filter {
    name   = "status"
    values = ["ok"]
  }
}

resource "random_shuffle" "linode_regions" {
  input = data.linode_regions.filtered-regions.regions[*].id
}

resource "linode_instance" "web" {
  count       = 3
  label       = "tf_created_instance-${count.index}"
  image       = "linode/ubuntu24.04"
  region      = random_shuffle.linode_regions.result[count.index]
  type        = "g6-nanode-1"
  root_pass   = "this-is-not-a-safe-password"
  firewall_id = 910692

  metadata {
    user_data = base64encode(templatefile("../cloud-config.tpl", { master = var.master }))
  }
  tags = ["wargames-2025"]

  lifecycle {
    ignore_changes = [region]
  }
}
