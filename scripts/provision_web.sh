#!/usr/bin/env bash

# Detener ejecución si ocurre cualquier error
set -e

echo "[+] Configurando Servidor Web: JoaquinAlonsoAdamsApache"

# Evita avisos interactivos durante la instalación
export DEBIAN_FRONTEND=noninteractive

echo "[+] Actualizando repositorios e instalando paquetes..."
apt-get update -y
apt-get install -y apache2 php libapache2-mod-php php-mysql git

echo "[+] Habilitando e iniciando servicio Apache..."
systemctl enable apache2
systemctl start apache2

echo "[+] Generando archivo de prueba PHP..."
cat << 'EOF' > /var/www/html/info.php
<?php
phpinfo();
?>
EOF

echo "[+] Verificando conectividad interna con la BD (192.168.56.20)..."
ping -c 2 192.168.56.20 || echo "[!] La base de datos aún no está disponible."

echo "[+] Aprovisionamiento del servidor Web completado exitosamente."