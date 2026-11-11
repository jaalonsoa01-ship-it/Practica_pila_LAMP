# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Box base: Debian 12 (Bookworm)
  config.vm.box = "debian/bookworm64"

  # 1. Servidor Web (Apache + PHP)
  config.vm.define "JoaquinAlonsoAdamsApache" do |web|
    web.vm.hostname = "JoaquinAlonsoAdamsApache"
    
    # Red privada interna para comunicarse con la base de datos
    web.vm.network "private_network", ip: "192.168.56.10"
    
    # Port Forwarding: Acceso desde el host (puerto 8080) al Apache (puerto 80)
    web.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

    # Aprovisionamiento mediante Script Bash
    web.vm.provision "shell", path: "scripts/provision_web.sh"

    # Configuración de recursos VirtualBox
    web.vm.provider "virtualbox" do |vb|
      vb.name = "JoaquinAlonsoAdamsApache"
      vb.memory = "4096"
      vb.cpus = 2
    end
  end


  # 2. Servidor de Base de Datos (MySQL / MariaDB)
  config.vm.define "JoaquinAlonsoAdamsMysql" do |db|
    db.vm.hostname = "JoaquinAlonsoAdamsMysql"
    
    # Red privada interna (aislada)
    db.vm.network "private_network", ip: "192.168.56.20"

    # Aprovisionamiento mediante Script Bash
    db.vm.provision "shell", path: "scripts/provision_db.sh"

    # Configuración de recursos VirtualBox
    db.vm.provider "virtualbox" do |vb|
      vb.name = "JoaquinAlonsoAdamsMysql"
      vb.memory = "4096"
      vb.cpus = 2
    end
  end
end