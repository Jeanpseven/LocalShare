#!/bin/bash

# Diretório de origem dos arquivos que você deseja compartilhar
diretorio_origem="/caminho/do/diretorio_de_origem"

# Diretório do servidor web (geralmente /var/www/html/)
diretorio_destino="/var/www/html"

# Verificar se o diretório de origem existe
if [ ! -d "$diretorio_origem" ]; then
    echo "O diretório de origem '$diretorio_origem' não existe."
    exit 1
fi

# Verificar se o diretório de destino existe
if [ ! -d "$diretorio_destino" ]; then
    echo "O diretório de destino '$diretorio_destino' não existe."
    exit 1
fi

# Copiar arquivos para o diretório de destino
cp -r "$diretorio_origem"/* "$diretorio_destino"

# Obter o endereço IP do servidor
endereco_ip=$(hostname -I | awk '{print $1}')

# Imprimir o link para acessar os arquivos no navegador
echo "Processo de compartilhamento de arquivos concluído."
echo "Acesse os arquivos no navegador usando o seguinte link:"
echo "http://$endereco_ip/$(basename $diretorio_destino)/"
