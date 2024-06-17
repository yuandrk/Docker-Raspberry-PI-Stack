variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 1
}

variable "worker_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 0
}

variable "user" {
  description = "The SSH user to connect to the nodes"
  type        = string
  default     = "ubuntu"
}

variable "master_host" {
  description = "The IP address or hostname of the master node"
  type        = string
}

variable "worker_host" {
  description = "The IP addresses or hostnames of the worker nodes"
  type        = string
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key"
  type        = string
  default     = "./k3s/keys/yuandrk_rass"
}