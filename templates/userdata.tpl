#!bin/bash

apt-get update -y
apt-get install nginx nginx-extras build-essential dirmngr gpg-agent apt-transport-https openssl -y
sh -c 'echo "deb https://weechat.org/ubuntu $(lsb_release -cs) main" >> /etc/apt/sources.list.d/weechat.list'
sh -c 'echo "deb https://weechat.org/debian stretch main" >> /etc/apt/sources.list.d/weechat.list'
apt-key adv --keyserver keys.gnupg.net --recv-keys 11E9DE8848F2B65222AA75B8D1820DB22A11534E
apt-get update
apt-get install weechat weechat-headless -y

useradd weechat

mkdir -p /usr/lib/systemd/system

cat <<'EOF' >> /etc/nginx/sites-available/weechat
${nginx_config}
EOF

cat <<'EOF' >> /lib/systemd/system/weechat.service
${weechat_service}
EOF

cat <<'EOF' >> ${weechat_env_file_path}
${weechat_env}
EOF

rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/weechat /etc/nginx/sites-enabled/default

export $(cat ${weechat_env_file_path} | xargs)
git clone https://x-access-token:$GITHUB_TOKEN@github.com/$GITHUB_USER/$GITHUB_REPOSITORY /home/weechat/.weechat
chown -R weechat:weechat /home/weechat

systemctl start weechat.service
systemctl start nginx.service
