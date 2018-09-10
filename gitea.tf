data "docker_registry_image" "gitea" {
  name = "gitea/gitea:latest"
}

resource "docker_image" "gitea" {
  name          = "${data.docker_registry_image.gitea.name}"
  pull_triggers = ["${data.docker_registry_image.gitea.sha256_digest}"]
}

# Merging and interpolation of variables : https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-

resource "docker_container" "gitea" {
  name  = "gitea"
  image = "${docker_image.gitea.latest}"
  links = ["postgres"]

  labels = "${merge(
    var.traefik-common-labels, map(
      "traefik.port", 3000,
      "traefik.frontend.rule","Host:git.${var.domain}"
  ))}"

  volumes {
    host_path      = "${var.mount_point}/data/gitea"
    container_path = "/data"
  }

  ports {
    external = 2222
    internal = 2222
  }

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

