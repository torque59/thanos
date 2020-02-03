data "docker_registry_image" "wikijs" {
  name = "requarks/wiki:latest"
}
resource "docker_image" "wikijs" {
  name          = "${data.docker_registry_image.wikijs.name}"
  pull_triggers = ["${data.docker_registry_image.wikijs.sha256_digest}"]
}
resource "docker_container" "wikijs" {
  name  = "wikijs"
  image = "${docker_image.wikijs.latest}"
  links = ["postgres"]

  labels = "${merge(
    var.traefik-common-labels, map(
      "traefik.port", 8081,
      "traefik.frontend.rule","Host:wiki.${var.domain}"
  ))}"

  volumes {
    host_path      = "${var.mount_point}/data/wikijs/repo"
    container_path = "/repo"
  }
   volumes {
    host_path      = "${var.mount_point}/data/wikijs/data"
    container_path = "/data"
  }
   upload {
    content = "${file("${path.module}/conf/wikijs.yml")}"
    file    = "/wiki/config.yml"
  }
   env = ["WIKI_ADMIN_EMAIL=${var.email}", "MONGODB_CONNECTION_URI=mongodb://mongodb:27017/wiki"]
   memory                = 512
   restart               = "unless-stopped"
   destroy_grace_seconds = 10
   must_run              = true
}
