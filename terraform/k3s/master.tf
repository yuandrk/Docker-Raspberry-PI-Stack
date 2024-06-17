resource "null_resource" "master" {

  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | sh -"
    ]

    connection {
      type        = "ssh"
      user        = var.user
      port        = 1580
      private_key = file("./k3s/keys/kub")
      host        = var.master_host
    }
  }
}