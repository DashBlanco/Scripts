## PREPARAMOS AMBIENTE
apt update && apt upgrade -y && apt install curl git -y

## CONFIGURAMOS TECLADO SI ES NECESARIO
export LANG=es_ES.UTF-8
dpkg-reconfigure locales

## DECORAMOS LA CLI
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

## INSTALAMOS APLICACIONES
apt install openssh-server ufw php php-fpm php-gd php-bcmath php-curl php-json php-mbstring php-mysql php-tokenizer php-xml php-zip php-cli mariadb-server composer certbot python3-certbot-nginx neofetch wget curl cron python3-full pipx -y

## CREAMOS ENVIROMENT PARA PYTHON
python -m venv my-venv
my-venv/bin/pip install --upgrade pip
python3 -m pip config set global.break-system-packages true

## ACTIVAMOS SERVICIOS
systemctl start ssh && systemctl start ufw && systemctl start nginx && systemctl start mariadb && systemctl enable ssh && systemctl enable ufw && systemctl enable nginx && systemctl enable mariadb

## INSTALACION MANUAL DE JAVA
wget https://download.oracle.com/java/23/latest/jdk-23_linux-x64_bin.deb
dpkg -i jdk-23_linux-x64_bin.deb
rm jdk-23_linux-x64_bin.deb
java -version

## ELIMINAMOS BASURA EXISTENTE POR DEFECTO
apt remove apache2

## CREAMOS PARTICION PARA EL DISCO 2T
fdisk /dev/vdb
n + enter + enter + w

## FORMATEMAOS PARTICION Y MONTAMOS
mkfs.ext4 /dev/vdb1 && mkdir -p /media/externo && mount /dev/vdb1 /media/externo

## CONFIGURAMOS FSTAB PARA MONTAJE AUTOMATICO DE LA PARTICION
blkid
nano /etc/fstab

UUID=4819cd6d-e448-4958-9425-0b93077dd438 /media/externo ext4 defaults 0 0

## REINICIMAOS Y VERIFICAMOS TODO
reboot

## PARCHES VARIOS - STORAGE LARAVEL
chown -R $USER:www-data storage && chown -R $USER:www-data bootstrap/cache && chown -R $USER:www-data lang && chmod -R 775 storage && chmod -R 775 bootstrap/cache && chmod -R 775 lang
## PARCHES VARIOS - PHPMYADMIN
chown -R $USER:www-data tmp && chmod -R 775 tmp
## PARCHES VARIOS - SUBIDA DE ARCHIVOS - nginx.conf (dentro del apartado HTTP)
client_max_body_size 5M;
## PARCHES VARIOS - SUBIDA DE ARCHIVOS - php.ini
memory_limit = 512M;
max_execution_time = 60;
post_max_size = 64M;
upload_max_filesize = 64M;

## CREAMOS USUSARIO PARA MARIADB
mysql -u root -p
CREATE USER 'dashdb'@'localhost' IDENTIFIED BY '@-App936Xb!';
GRANT ALL PRIVILEGES ON * . * TO 'dashdb'@'localhost';
FLUSH PRIVILEGES;
exit;

## CONFIGURAMOS BACKUPS DE LA BASE DE DATOS
mkdir /media/backups
chmod 777 /media/backups

## DIARIOS 3AM:
crontab -e
00 3 * * * root mysqldump -u dashdb -p@-App936Xb! --all-databases | gzip > /media/backups/$(date +%Y-%m-%d).sql.gz
## QUINCENALES 3AM:
crontab -e
00 3 15 * * root mysqldump -u dashdb -p@-App936Xb! --all-databases | gzip > /media/backups/$(date +%Y-%m-%d).sql.gz

## REINICIAMOS CRON
systemctl restart cron