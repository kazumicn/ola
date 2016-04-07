# Update & upgrade
sudo apt-get update
sudo apt-get upgrade

# Install & start nginx
sudo apt-get install nginx -y
sudo service nginx start

# Install git
sudo apt-get install git -y

# Install letsencrypt
sudo git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt

# Install letsencrypt dependencies
sudo /opt/letsencrypt/letsencrypt-auto --help all

# Stop nginx (port 80 needed by letsencrypt)
sudo nginx service stop

# Generate certificate
sudo /opt/letsencrypt/letsencrypt-auto certonly --rsa-key-size 4096

# Generate a strong Diffie-Hellman (2048-bit) group
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Config nginx to use certificate (see nginx-config.conf)
sudo vim /etc/nginx/sites-available/secure.example.com
sudo ln -s /etc/nginx/sites-available/secure.example.com /etc/nginx/sites-enabled/secure.example.com

# Restart nginx
sudo service nginx start

# Test SSL config with https://www.ssllabs.com/ssltest/

# Install firewall (ufw)
sudo apt-get install ufw -y

# Open SSH, HTTP & HTTPS ports
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Enable ufw
sudo ufw enable
sudo ufw status

# Configure SSL certificate renew with letsencrypt & cron
# /opt/letsencrypt/letsencrypt-auto renew
sudo crontab -e

# Add to crontab (to auto renew certs every monday)
# 30 2 * * 1 /opt/letsencrypt/letsencrypt-auto renew >> /var/log/le-renew.log
# 35 2 * * 1 /etc/init.d/nginx reload

# Sources
# - https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-14-04
# - https://www.digitalocean.com/community/tutorials/how-to-configure-nginx-with-ssl-as-a-reverse-proxy-for-jenkins