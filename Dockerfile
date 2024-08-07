FROM wordpress:latest

EXPOSE 80

COPY wp-config.php /var/www/html/

RUN chown www-data:www-data /var/www/html/wp-config.php
