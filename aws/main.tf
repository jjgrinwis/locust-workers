# creating 5 different ec2 instances in different regions
# this must be all statically configures, not possible to dynamically set the provider
data "aws_ami" "ubuntu_eu_west_1" {
  provider = aws.eu_west_1
  owners   = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20241109"]
  }
}

data "aws_ami" "ubuntu_eu_central_1" {
  provider = aws.eu_central_1
  owners   = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20241109"]
  }
}

data "aws_ami" "ubuntu_us_west_1" {
  provider = aws.us_west_1
  owners   = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20241109"]
  }
}

data "aws_ami" "ubuntu_ap_southeast_1" {
  provider = aws.ap_southeast_1
  owners   = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20241109"]
  }
}

resource "aws_instance" "ubuntu_eu_west_1" {
  count                       = var.instances_per_region
  provider                    = aws.eu_west_1
  ami                         = data.aws_ami.ubuntu_eu_west_1.id
  instance_type               = "t2.micro"
  user_data                   = templatefile("../cloud-config.tpl", { master = var.master })
  user_data_replace_on_change = true

  tags = {
    Name = "aws-locust-${count.index}-eu_west_1"
  }
}

resource "aws_instance" "ubuntu_eu_central_1" {
  count                       = var.instances_per_region
  provider                    = aws.eu_central_1
  ami                         = data.aws_ami.ubuntu_eu_central_1.id
  instance_type               = "t2.micro"
  user_data                   = templatefile("../cloud-config.tpl", { master = var.master })
  user_data_replace_on_change = true
  key_name                    = "ec2"

  tags = {
    Name = "aws-locust-${count.index}-ubuntu_eu_central_1"
  }
}

resource "aws_instance" "ubuntu_us_west_1" {
  count                       = var.instances_per_region
  provider                    = aws.us_west_1
  ami                         = data.aws_ami.ubuntu_us_west_1.id
  instance_type               = "t2.micro"
  user_data                   = templatefile("../cloud-config.tpl", { master = var.master })
  user_data_replace_on_change = true

  tags = {
    Name = "aws-locust-${count.index}-ubuntu_us_west_1"
  }
}

resource "aws_instance" "ubuntu_ap_southeast_1" {
  count                       = var.instances_per_region
  provider                    = aws.ap_southeast_1
  ami                         = data.aws_ami.ubuntu_ap_southeast_1.id
  instance_type               = "t2.micro"
  user_data                   = templatefile("../cloud-config.tpl", { master = var.master })
  user_data_replace_on_change = true

  tags = {
    Name = "aws-locust-${count.index}-ubuntu_ap_southeast_1"
  }
}
