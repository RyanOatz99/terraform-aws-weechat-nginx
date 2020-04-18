variable vpc_id {
  description = "The VPC this instance should be placed in"
}

variable vpc_cidr_block {
  description = "The cidr block of the VPC the instance will be placed in"
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

variable github_token {
  description = "this token will be used to clone weechat onfig repo and sync with it"
}

variable weechat_env_file_path {
  description = "The weechat env variable file will be copied to this path on the server"
  type = string
  default = "/usr/weechat_env"
}

variable github_username {
  description = "The github username"
  type = string
}

variable fqdn {
  description = "The FQDN that will target this instance"
}

variable key_name {
  description = "SSH key pair name to attach to the instance"
}

variable relay_password {
  description = "Weechat relay password"
}
