provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket         = "tf-state-bucket-841618907879"
    region         = "eu-central-1"
    dynamodb_table = "tf_state_db"
    encrypt        = true

    key = "netology/s3/terraform.tfstate"
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*ubuntu-jammy-22.04-amd64-server*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.env_settings[terraform.workspace].type
  count         = var.env_settings[terraform.workspace].instances

  tags = {
    Name = "${var.env_settings[terraform.workspace].nameprefix}-${count.index}"
  }
}


resource "aws_instance" "web_foreach" {
  ami           = data.aws_ami.ubuntu.id
  for_each      = local.instances[terraform.workspace]
  instance_type = var.env_settings[terraform.workspace].type
  tags = {
    Name = each.value.name
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
