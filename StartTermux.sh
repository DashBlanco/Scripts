## PREPARAMOS AMBIENTE
pkg update && pkg upgrade -y 
apt update && apt upgrade -y 

## HABILITAMOS ALMACENAMIENTO
termux-setup-storage

## INSTALAMOS PROGRAMAS BASICOS
apt install termux-tools termux-services wget git openssh -y

## PERSONALIZAMOS SHELL
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"