variable "vultr_api_key" {
  type      = string
  sensitive = true
}

variable "ssh_pubkey_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
