# Manages CNAME creation for the subdomains to be managed by trafeik.

# Currently a bug in digital-ocean terraform does not map CNAME records properly hence done manually. This should work once the fix kicks in.

/*

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_record" "thanos" {
  domain = "${var.domain}"
  name   = "thanos"
  type   = "CNAME"
  value  = "main.francisalexander.in"
  ttl    = 3600
}

# Add a record to the domain
resource "digitalocean_record" "git" {
  domain = "${digitalocean_record.thanos.name}.${var.domain}"
  type   = "CNAME"
  name   = "git"
  ttl 	 = 3600
}
*/
