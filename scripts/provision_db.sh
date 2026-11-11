#!/usr/bin/env bash

# Detener ejecución si ocurre cualquier error
set -e

echo "[+] Configurando Servidor de Base de Datos: JoaquinAlonsoAdamsMysql"

# Evita avisos interactivos durante la instalación
export DEBIAN_FRONTEND=noninteractive

echo "[+] Actualizando e instalando MariaDB Server..."
apt-get update -y
apt-get install -y mariadb-server

echo "[+] Eliminando Default Gateway en eth0 (Restricción de acceso a Internet)..."
# Remueve la ruta por defecto a Internet asignada a la interfaz NAT de Vagrant
ip route del default dev eth0 || true

echo "[+] Permitiendo conexiones remotas desde el servidor web..."
# Reemplaza la escucha local (127.0.0.1) por todas las interfaces (0.0.0.0)
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

echo "[+] Reiniciando MariaDB..."
systemctl restart mariadb
systemctl enable mariadb

echo "[+] Creando base de datos y otorgando permisos al Servidor Web..."
mysql -u root << 'EOF'
CREATE DATABASE IF NOT EXISTS lamp_db;
CREATE USER IF NOT EXISTS 'lamp_user'@'192.168.56.10' IDENTIFIED BY '1212';
GRANT ALL PRIVILEGES ON lamp_db.* TO 'lamp_user'@'192.168.56.10';
FLUSH PRIVILEGES;
EOF

echo "[+] Aprovisionamiento del servidor de Base de Datos completado exitosamente."
