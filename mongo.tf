data "docker_registry_image" "mongo" {
  name = "mongo:latest"
}

resource "docker_image" "mongo" {
  name          = "${data.docker_registry_image.mongo.name}"
  pull_triggers = ["${data.docker_registry_image.mongo.sha256_digest}"]
}

resource "docker_container" "mongo" {
  name     = "mongo"
  image    = "${docker_image.mongo.name}"
  hostname = "mongodb"

  volumes {
    host_path      = "${var.mount_point}/db/mongo"
    container_path = "/data/db"
  }

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

