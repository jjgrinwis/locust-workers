# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# using random 
provider "random" {}

# get all our regions
data "digitalocean_regions" "filtered-regions" {
  filter {
    key    = "available"
    values = ["true"]
  }
}

resource "random_shuffle" "linode_regions" {
  input = data.digitalocean_regions.filtered-regions.regions[*].slug
}

resource "digitalocean_droplet" "web" {
  count     = var.number_of_instances
  image     = "ubuntu-24-10-x64"
  name      = "do-locust-${count.index}-${random_shuffle.linode_regions.result[count.index]}"
  region    = random_shuffle.linode_regions.result[count.index]
  size      = "s-1vcpu-1gb"
  backups   = false
  user_data = templatefile("../cloud-config.tpl", { master = var.master })
  tags      = ["wargames-2025"]
  ssh_keys  = [40309226] # id_ed25519
  lifecycle {
    ignore_changes = [region]
  }
}
