
cd
mkdir -p /var/www/localhost
cp /root/nginx_local_host.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/nginx_local_host.conf /etc/nginx/sites-enabled/
rm -rf /etc/nginx/sites-enabled/default

mkdir /etc/nginx/ssl
chmod 700 /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=pacorrei/CN=pacorrei"

wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
mkdir /var/www/localhost/phpmyadmin
tar -xzf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/localhost/phpmyadmin
cp /root/config.inc.php /var/www/localhost/phpmyadmin/

cd /var/www/localhost
wget https://fr.wordpress.org/latest-fr_FR.tar.gz
tar -xzvf latest-fr_FR.tar.gz
rm latest-fr_FR.tar.gz
cp /root/wp-config.php /var/www/localhost/wordpress

service mysql start
service php7.3-fpm start
echo "CREATE DATABASE wordpress;" | mysql -uroot
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'admin'@'localhost' identified by 'admin';" | mysql -uroot
echo "FLUSH PRIVILEGES" | mysql -uroot
#echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -uroot


chown -R www-data /var/www/*
chmod -R 755 /var/www/*

service nginx restart
service php7.3-fpm restart

bash