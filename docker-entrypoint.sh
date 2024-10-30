#!/bin/bash
env >> /etc/environment
cd /var/www/html && composer install -n
# /usr/local/bin/php /var/www/html/bin/cake.php migrations migrate
chown -R www-data:www-data /var/www/html/logs
chown -R www-data:www-data /var/www/html/tmp
apache2-foreground &
touch /var/www/html/logs/error.log
tail -f /var/www/html/logs/error.log
