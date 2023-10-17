import shutil
import os

# Diretório do servidor web (geralmente /var/www/html/)
diretorio_destino = '/var/www/html'

# Verificar se o diretório de destino existe
if not os.path.exists(diretorio_destino):
    print(f"O diretório de destino '{diretorio_destino}' não existe.")
    exit(1)

# Obter o diretório atual como diretório de origem
diretorio_origem = os.getcwd()

# Copiar arquivos para o diretório de destino
for root, _, files in os.walk(diretorio_origem):
    for arquivo in files:
        caminho_arquivo_origem = os.path.join(root, arquivo)
        caminho_arquivo_destino = os.path.join(diretorio_destino, arquivo)

        try:
            shutil.copy(caminho_arquivo_origem, caminho_arquivo_destino)
            print(f"Arquivo '{arquivo}' copiado com sucesso para o diretório de destino.")
        except Exception as e:
            print(f"Erro ao copiar arquivo '{arquivo}': {e}")

# Obter o endereço IP do servidor
import socket
endereco_ip = socket.gethostbyname(socket.gethostname())

# Imprimir o link para acessar os arquivos no navegador
print("Processo de compartilhamento de arquivos concluído.")
print(f"Acesse os arquivos no navegador usando o seguinte link:")
print(f"http://{endereco_ip}/{os.path.basename(diretorio_destino)}/")
