#!/bin/bash

apt-get update
apt-get install -y docker.io netcat-openbsd
systemctl start docker
systemctl enable docker

DB_HOST="${db_host}"
DB_PORT="${db_port}"

echo "Waiting for database at $DB_HOST:$DB_PORT..."
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 2
  echo "Database not ready yet..."
done
echo "Database is UP!"

cat <<EOF > /root/.uevent.env
DB_HOST=${db_host}
DB_PORT=${db_port}
DB_USERNAME=${db_username}
DB_PASSWORD=${db_password}
DB_NAME=${db_name}
EOF