variable vpc_id {
  description = "The VPC this instance should be placed in"
}

variable subnet_id {
  description = "The subnet id"
}

variable weechat_config_repository_name {
  description = "the github repository name"
  type = string
}

variable instance_type {
  type = string
  default = "t3.nano"
}

variable weechat_env_file_path {
  description = "The weechat env variable file will be copied to this path on the server"
  type = string
  default = "/usr/weechat_env"
}

variable fqdn {
  description = "The FQDN of the domain connected to this instance"
}

variable key_name {
  description = "SSH key pair name to attach to the instance"
}

variable weechat_config_deploy_private_key_path {
  description = "Weechat config deploy key path"
}

variable relay_password {
  description = "Weechat relay password"
}
