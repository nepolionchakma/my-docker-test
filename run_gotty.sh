#!/bin/bash


# Define passwords

DEF_PASSWORD="def"
DBS_PASSWORD="dbs"
APP_PASSWORD="app"
WEB_PASSWORD="web"

# Create users with defined passwords
sudo useradd -m -d /home/def -s /bin/bash def
echo "def:$DEF_PASSWORD" | sudo chpasswd
sudo useradd -m -d /home/dbs -s /bin/bash dbs
echo "dbs:$DBS_PASSWORD" | sudo chpasswd
sudo useradd -m -d /home/app -s /bin/bash app
echo "app:$APP_PASSWORD" | sudo chpasswd
sudo useradd -m -d /home/web -s /bin/bash web
echo "web:$WEB_PASSWORD" | sudo chpasswd

echo "User Created!"

# Create Group admin and add users (avoid wheel group)
groupadd admin
usermod -aG admin def
usermod -aG admin dbs
usermod -aG admin app
usermod -aG admin web
echo "Group admin created and all users are added to the group admin."

# Provide sudo permission:
usermod -aG sudo def
usermod -aG sudo dbs
usermod -aG sudo app
usermod -aG sudo web
echo "SUDO permission have been provided to all users."


# Create directories with appropriate permissions
mkdir -p /d01
mkdir -p /d01/def/{data,app,web}
mkdir -p /d01/def/app/server
mkdir -p /d01/def/app/server/{flask,node,socket}
chown root:admin /d01
chown def:admin /d01/def
chown dbs:admin /d01/def/data
chown -R app:admin /d01/def/app
chown -R web:admin /d01/def/web
chmod -R 774 /d01  # Restrict access to /d01 (optional: adjust based on needs)
echo "All required directory have been created."
/usr/local/bin/gotty --permit-write --reconnect /bin/bash
