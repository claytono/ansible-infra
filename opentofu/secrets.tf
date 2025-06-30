# Reference to the existing Kubernetes vault
data "onepassword_vault" "kubernetes" {
  uuid = "duipvbtxrc4wl22tw3jsihfo2m"
}

# Vultr API credentials from 1Password
data "onepassword_item" "vultr_api" {
  vault = data.onepassword_vault.kubernetes.uuid
  title = "Vultr API"
}

# Backblaze B2 credentials from 1Password (master key with writeBuckets permission)
data "onepassword_item" "terraform_b2" {
  vault = data.onepassword_vault.kubernetes.uuid
  title = "terraform-b2"
}

# Clean field mapping for B2 credentials
locals {
  b2_fields = {
    for f in flatten([
      for sec in data.onepassword_item.terraform_b2.section : sec.field
    ]) : f.label => f.value
  }
}

# Local values for easier reference
locals {
  vultr_api_key = data.onepassword_item.vultr_api.password

  # B2 credentials using clean field mapping
  b2_application_key_id = local.b2_fields["RCLONE_CONFIG_B2_ACCOUNT"]
  b2_application_key    = local.b2_fields["RCLONE_CONFIG_B2_KEY"]
}
