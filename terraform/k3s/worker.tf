resource "null_resource" "worker" {
  count = var.worker_count

  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | K3S_URL=https://your-master-node-ip:6443 K3S_TOKEN=${file("/var/lib/rancher/k3s/server/node-token")} sh -"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host        = "your-worker-node-ip"
    }
  }
}