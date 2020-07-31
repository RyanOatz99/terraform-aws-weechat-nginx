map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

upstream weechat {
    server 127.0.0.1:9001;
}

server {
  listen 80;
  server_name weechat.${fqdn};


  location /weechat {
      proxy_pass http://weechat;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
      proxy_read_timeout 4h;
  }
}

