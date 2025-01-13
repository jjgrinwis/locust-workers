variable "linode_token" {
  description = "The Linode API token to use"
  type        = string
}

variable "master" {
  description = "The IP address of our master locust node"
  type        = string
}

variable "root_password" {
  description = "root password defined in CF cloud"
  type        = string
  sensitive   = true
}
