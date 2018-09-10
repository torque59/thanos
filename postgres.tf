data "docker_registry_image" "postgres" {
  name = "postgres:alpine"
}

resource "docker_image" "postgres" {
  name          = "${data.docker_registry_image.postgres.name}"
  pull_triggers = ["${data.docker_registry_image.postgres.sha256_digest}"]
}

resource "docker_container" "postgres" {
  name     = "postgres"
  image    = "${docker_image.postgres.name}"
  hostname = "postgresdb"

  volumes {
    host_path      = "${var.mount_point}/db/postgres"
    container_path = "/var/lib/postgresql/data"
  }

  upload {
    content = "${file("${path.module}/conf/gitea.sql")}"
    file    = "/docker-entrypoint-initdb.d/gitea.sql"
  }

  env = [
    "POSTGRES_USER=${var.postgres_username}",
    "POSTGRES_PASSWORD=${var.postgres_password}"]

  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}
