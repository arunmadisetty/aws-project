#!/bin/bash
# Update all packages
yum update -y

# Install Apache web server and PHP
yum install -y httpd mysql php php-mysqlnd wget

# Start and enable Apache to start on boot
systemctl start httpd
systemctl enable httpd

# Download and install WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* .
rm -rf wordpress latest.tar.gz

# Set permissions for Apache
chown -R apache:apache /var/www/html

# Configure WordPress to use the provided database credentials
cp wp-config-sample.php wp-config.php

# Replace placeholders with environment variables
sed -i "s/database_name_here/${db_name}/" wp-config.php
sed -i "s/username_here/${db_user}/" wp-config.php
sed -i "s/password_here/${db_password}/" wp-config.php
sed -i "s/localhost/${db_host}/" wp-config.php

# Restart Apache to apply changes
systemctl restart httpd

