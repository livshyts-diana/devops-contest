#!/bin/sh
echo "<html><body><h1>Diana Sandbox 2021</h1><h2>DEVOPS Variable: ${DEVOPS}</h2></body></html>" > /usr/share/nginx/html/index.html
exec nginx -g "daemon off;"
