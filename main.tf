data "template_file" "weechat_service" {
  template = "${file("${path.module}/templates/weechat.service.tpl")}"
  vars = {
    weechat_env_file_path = var.weechat_env_file_path
  }
}

data "template_file" "nginx_config" {
  template = "${file("${path.module}/templates/nginx_config.tpl")}"
  vars = {
    fqdn = var.fqdn
  }
}


data "template_file" "weechat_env" {
  template = "${file("${path.module}/templates/weechat_env.tpl")}"
  vars = {
    github_token = var.github_token
    github_username = var.github_username
    weechat_config_repo = var.weechat_config_repository_name
    relay_password = var.relay_password
  }
}

data "template_file" "userdata" {
  template = "${file("${path.module}/templates/userdata.tpl")}"
  vars = {
    nginx_config = data.template_file.nginx_config.rendered
    weechat_service = data.template_file.weechat_service.rendered
    weechat_env_file_path = var.weechat_env_file_path
    weechat_env = data.template_file.weechat_env.rendered
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "weechat_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = [aws_security_group.allow_http.id]
  subnet_id = var.subnet_id
  user_data = data.template_file.userdata.rendered
}
