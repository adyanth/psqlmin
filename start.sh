#!/bin/bash

# Get env vars with defaults
USER=${WEB_USERNAME:-postgres}
PASS=${WEB_PASSWORD:-postgres}
PORT=${WEB_PORT:-8080}

# Create user and set acl
echo "$USER:x:0" > /etc/webmin/miniserv.users
echo "$USER: postgresql" > /etc/webmin/webmin.acl

# Set default dashboard for user
mkdir -p /etc/webmin/authentic-theme/
echo "settings_webmin_default_module='postgresql';" \
  > /etc/webmin/authentic-theme/settings-"$USER".js

# Change password
/usr/share/webmin/changepass.pl /etc/webmin "$USER" "$PASS"

# Change port
sed -i -e "s/port=.*/port=${PORT}/" /etc/webmin/miniserv.conf
sed -i -e "s/listen=.*/listen=${PORT}/" /etc/webmin/miniserv.conf

# Start service (needs a restart to pick up port change)
service webmin start
service webmin restart

docker-entrypoint.sh "$@"
