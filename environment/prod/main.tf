locals {
  env = "prod"
}

provider "google" {
  project = "${var.project}"
}

module "vpc" {
  source  = "../../module/vpc"
  project = "${var.project}"
  env     = "${local.env}"
  region  = "${var.region}"
}

module "http_server" {
  source  = "../../module/http_server"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet}"
  env     = "${local.env}"
}

module "firewall" {
  source  = "../../module/firewall"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet}"
}
