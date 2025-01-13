variable "do_token" {
  description = "The Digital Ocean API token to use"
  type        = string
}

variable "master" {
  description = "The IP address of our master locust node"
  type        = string
}

variable "number_of_instances" {
  description = "How many instances to boot in this cloud provider"
  type        = number
  default     = 3
}
