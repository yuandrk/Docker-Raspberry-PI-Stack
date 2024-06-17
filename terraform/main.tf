terraform {
  required_version = ">= 0.14"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

provider "null" {}

provider "template" {}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "k3s" {
  source       = "./k3s"
  user         = var.user
  master_host  = var.master_host
  worker_host  = var.worker_host
}