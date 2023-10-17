#!/bin/bash

# Solicitar o nome da pasta compartilhada
read -p "Digite o nome da pasta compartilhada: " pasta_compartilhada

# Verificar se o SAMBA está instalado
if ! [ -x "$(command -v smbclient)" ]; then
  echo "O SAMBA não está instalado. Instalando..."
  sudo apt-get update
  sudo apt-get install samba -y
fi

# Criar a pasta compartilhada
mkdir ~/"$pasta_compartilhada"

# Configurar o compartilhamento no arquivo smb.conf
config_samba="[${pasta_compartilhada}]
   comment = Shared Folder
   path = /home/$(whoami)/${pasta_compartilhada}
   browseable = yes
   read only = no
   guest ok = yes
"
echo "$config_samba" | sudo tee -a /etc/samba/smb.conf

# Reiniciar o serviço SAMBA
sudo service smbd restart

# Obter o endereço IP local
local_ip=$(hostname -I | awk '{print $1}')

# Imprimir o endereço IP e a URL de acesso
echo "Pasta compartilhada \"$pasta_compartilhada\" criada com sucesso!"
echo "Endereço IP local do servidor: $local_ip"
echo "Você pode acessar a pasta em smb://$local_ip/$pasta_compartilhada"
