# Reference to the existing Kubernetes vault
data "onepassword_vault" "kubernetes" {
  uuid = "duipvbtxrc4wl22tw3jsihfo2m"
}

# Vultr API credentials from 1Password
data "onepassword_item" "vultr_api" {
  vault = data.onepassword_vault.kubernetes.uuid
  title = "Vultr API"
}

# Local values for easier reference
locals {
  vultr_api_key = data.onepassword_item.vultr_api.password
}
