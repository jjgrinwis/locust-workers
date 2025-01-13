variable "region_aliases" {
  type = list(string)
  default = [
    "ap_northeast_2", "ap_northeast_3", "ap_northeast_3", "ap_south_1",
    "ap_southeast_1", "ap_southeast_2", "ca_central_1", "eu_central_1",
    "eu_north_1", "eu_west_1", "eu_west_2", "eu_west_3", "sa_east_1",
    "us_east_1", "us_east_2", "us_west_1", "us_west_2"
  ]
}

variable "instances_per_region" {
  description = "ec2 instances per region"
  type        = number
  default     = 1
}

variable "master" {
  description = "The IP address of our master locust node"
  type        = string
}
