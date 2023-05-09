variable "aws_region_name" {
  default = "eu-central-1"
}

locals {
  instances = {
    stage = {
      web-01 = {
        name = "${var.env_settings[terraform.workspace].nameprefix}-01"
      }
    }
    prod = {
      web-01 = {
        name = "${var.env_settings[terraform.workspace].nameprefix}-01"
      }
      web-02 = {
        name = "${var.env_settings[terraform.workspace].nameprefix}-02"
      }
    }
  }
}

variable "env_settings" {
  default = {
    prod = {
      instances  = 2
      nameprefix = "prod-srv"
      type       = "t2.small"
    }
    stage = {
      instances  = 1
      nameprefix = "stage-srv"
      type       = "t2.micro"
    }
  }
}
