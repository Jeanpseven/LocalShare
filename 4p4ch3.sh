#!/bin/bash

# Diretório do servidor web (geralmente /var/www/html/)
diretorio_destino="/var/www/html"

# Verificar se o diretório de destino existe
if [ ! -d "$diretorio_destino" ]; then
    echo "O diretório de destino '$diretorio_destino' não existe."
    exit 1
fi

# Obter o diretório atual como diretório de origem
diretorio_origem=$(pwd)

# Copiar arquivos para o diretório de destino
cp -r "$diretorio_origem"/* "$diretorio_destino"

# Obter o endereço IP do servidor
endereco_ip=$(hostname -I 2>/dev/null | awk '{print $1}')

# Verificar se o endereço IP foi obtido corretamente
if [ -z "$endereco_ip" ]; then
    echo "Não foi possível obter o endereço IP do servidor."
    exit 1
fi

# Imprimir o link para acessar os arquivos no navegador
echo "Processo de compartilhamento de arquivos concluído."
echo "Acesse os arquivos no navegador usando o seguinte link:"
echo "http://$endereco_ip/$(basename $diretorio_destino)/"
