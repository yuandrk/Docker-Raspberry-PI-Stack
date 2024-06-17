provider "local" {
  version = "~> 2.0"
}

provider "null" {
  version = "~> 3.0"
}

provider "template" {
  version = "~> 2.0"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "k3s" {
  source = "./k3s"
  master_count = 1
  worker_count = 1
}

module "argocd" {
  source = "./argocd"
}