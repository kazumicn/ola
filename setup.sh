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
sudo /opt/letsencrypt-auto --help all

# Stop nginx (port 80 needed by letsencrypt)
sudo nginx service stop

# Generate certificate
sudo /opt/letsencrypt-auto certonly --rsa-key-size 4096

# Generate a strong Diffie-Hellman (2048-bit) group
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Config nginx to use certificate (see nginx-config.conf)
sudo vim /etc/nginx/sites-available/default

# Restart nginx
sudo service nginx start

# Test SSL config with https://www.ssllabs.com/ssltest/

# Configure iptables (see iptables.rules)
sudo vim /etc/iptables.test.rules
sudo iptables-restore < /etc/iptables.test.rules
sudo iptables -L

# TODO auto renew