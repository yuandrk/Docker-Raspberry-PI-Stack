resource "null_resource" "worker" {
  
  provisioner "local-exec" {
    command = <<EOT
      ssh -i ${var.ssh_private_key_path} -p 22 ${var.user}@${var.worker_host} 'sudo cat /var/lib/rancher/k3s/server/node-token' > ./k3s_token.txt
    EOT
  }

  provisioner "remote-exec" {
    inline = [
      "K3S_TOKEN=$(cat /tmp/k3s_token.txt)",
      "curl -sfL https://get.k3s.io | K3S_URL=https://${var.worker_host}:6443 K3S_TOKEN=$K3S_TOKEN sh -"
    ]

    connection {
      type        = "ssh"
      user        = var.user
      port        = 22
      private_key = file(var.ssh_private_key_path)
      host        = var.worker_host
    }
  }
}