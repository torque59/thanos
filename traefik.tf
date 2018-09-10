provider "docker" {
  host = "unix:///var/run/docker.sock"
}

data "docker_registry_image" "traefik" {
  name = "traefik:latest"
}

resource "docker_image" "traefik" {
  name          = "${data.docker_registry_image.traefik.name}"
  pull_triggers = ["${data.docker_registry_image.traefik.sha256_digest}"]
}

resource "docker_container" "traefik" {
  name  = "traefik"
  image = "${docker_image.traefik.latest}"

  volumes {
	host_path         = "/var/run/docker.sock"
	container_path    = "/var/run/docker.sock"
	read_only         = true
  }

  volumes {
    host_path      = "${var.mount_point}/config/acme"
    container_path = "/acme"
  }

  upload {
    content = "${file("${path.module}/conf/traefik.toml")}"
    file    = "/etc/traefik/traefik.toml"
  }

  ports {
    external = 80
    internal = 80
  }

  ports {
    external = 443
    internal = 443
  }

  ports {
    external = 8080
    internal = 8080
  }

  env = ["DO_AUTH_TOKEN=${var.do_token}"]

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

}
