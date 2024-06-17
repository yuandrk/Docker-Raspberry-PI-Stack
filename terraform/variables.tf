variable "user" {
  description = "The SSH user to connect to the nodes"
  type        = string
  default     = "yuandrk"
}

variable "master_host" {
  description = "The IP address or hostname of the master node"
  type        = string
}

variable "worker_host" {
  description = "The IP addresses or hostnames of the worker nodes"
  type        = string
}

