#### Introduction

This whole setup was so that i could write my infrastructure using terraform and get it deployed on docker.

- Traefik as reverse proxy/router.
- Notes is one thing i often take down, and thought this would be great.
- Gitea, for self-hosted private repos.

#### Infrastructure

Terraform -> docker -> Trafeik -> git.francisalexander.in
		               -> wiki.francisalexander.in


#### Terraform 101

- terraform init thanos/ # Should initialise the terraform plugins required, ex: docker,digitalocean
- terraform plan -out=prod-thanos thanos/ # Should plan out the entire structure and you should see zero errors. Initialist your secret variables using terraform.tfvars
- terraform apply prod-thanos
