locals {
  env = "dev"
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

module "firewall" {
  source  = "../../sdlc/module/firewall"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet}"
}

module "http_server" {
  source  = "../../sdlc/module/http_server"
  project = "${var.project}"
  subnet  = "${module.vpc.subnet}"
}

module "gke" {
  source = "../../sdlc/module/gke"
  project = "${var.project}"
  cluster_name_suffix = "${var.cluster_name_suffix}"
  region = "${var.region}"
  subnetwork = "${element(module.vpc.subnets_names, 0)}"
  ip_range_pods = "${var.ip_range_pods}"
  ip_range_services = "${var.ip_range_services}"
  compute_engine_service_account = "${var.compute_engine_service_account}"
  env = "${local.env}"
}

