import os

# Solicitar o nome da pasta compartilhada
pasta_compartilhada = input("Digite o nome da pasta compartilhada: ")

# Criar a pasta compartilhada
if not os.path.exists(pasta_compartilhada):
    os.makedirs(pasta_compartilhada)

# Configurar o compartilhamento no arquivo smb.conf
compartilhamento = f"[{pasta_compartilhada}]\n" \
                  f"   path = {os.path.abspath(pasta_compartilhada)}\n" \
                  f"   browseable = yes\n" \
                  f"   read only = no\n" \
                  f"   guest ok = yes\n"

with open("/etc/samba/smb.conf", "a") as smb_conf:
    smb_conf.write(compartilhamento)

# Reiniciar o serviço SAMBA
os.system("sudo service smbd restart")

# Obter o endereço IP local
local_ip = os.popen("hostname -I | awk '{print $1}'").read().strip()

# Imprimir o endereço IP e a URL de acesso
print(f"Pasta compartilhada \"{pasta_compartilhada}\" criada com sucesso!")
print(f"Endereço IP local do servidor: {local_ip}")
print(f"Você pode acessar a pasta em smb://{local_ip}/{pasta_compartilhada}")
