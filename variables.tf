variable "domain" {
	type = "string"
	default = "francisalexander.in"
}

variable "mount_point" {
	type = "string"
	default = "/home/torque/thanos/"
}

variable "do_token" {
  type    = "string"
}

variable "gitea_dbname" {
  type = "string"
  default = "gitea"
}

variable "gitea_db_username" {
  type = "string"
  default = "gitea"
}

variable "gitea_db_passphrase" {
  type = "string"
  default = "gitea"
}

variable "postgres_username" {
  type = "string"
  default = "admin"
}

variable "postgres_password" {
  type = "string"
  default = "admin"
}

variable "traefik-common-labels" {
  type = "map"
  default = {
    "traefik.frontend.passHostHeader"                  = "true"
    "traefik.protocol"                                 = "http"
    "traefik.enable"                                   = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect"    = "true"
    "traefik.frontend.headers.STSSeconds"              = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains"    = "false"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"

  }
}

