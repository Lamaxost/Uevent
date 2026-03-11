#!/bin/bash
# 1. Install Docker and Netcat
apt-get update
apt-get install -y docker.io netcat-openbsd
systemctl start docker
systemctl enable docker

# 2. Variables from Terraform
DB_HOST="${db_host}"
DB_PORT="${db_port}"

# 3. Wait for Database to be reachable
echo "Waiting for database at $DB_HOST:$DB_PORT..."
while ! nc -z $DB_HOST $DB_PORT; do
  sleep 2
  echo "Database not ready yet..."
done
echo "Database is UP!"

# 4. Pull and Run Backend
docker pull ${docker_username}/uevent-backend:latest

cat <<EOF > /root/.uevent.env
DB_HOST=${db_host}
DB_PORT=${db_port}
DB_USERNAME=${db_username}
DB_PASSWORD=${db_password}
DB_NAME=${db_name}
EOF