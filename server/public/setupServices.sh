#!/bin/bash
set -e

apt-get install -y podman nginx

# ========== STATIC PAGES ==========
echo "Setup static pages"
site1=/var/www/heid.cc
mkdir -p $site1
chmod 700 /var/www

cp conf/index.html $site1/index.html
echo "Setup static pages - Done"

# ========== NGINX ==========
echo "Configuring NGINX"
cp conf/nginx-default.conf /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
systemctl restart nginx
echo "Configuring NGINX - Done"

#snap install --classic certbot
#ln -s /snap/bin/certbot /usr/bin/certbot
#certbot --nginx
#certbot renew --dry-run
