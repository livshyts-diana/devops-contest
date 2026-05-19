#!/bin/bash
apt-get update -y
apt-get install nginx -y
OS_VERSION=$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f 2)
echo "<html><body><h1>Hello World</h1><p>OS Version: $OS_VERSION</p></body></html>" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx
