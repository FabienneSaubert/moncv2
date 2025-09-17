#Définir l'OS
FROM debian:bullseye-slim

#Installation de apache2
RUN apt update && apt install -y apache2 && rm -rf /var/lib/apt/lists/*

#Création du dossier dans docker
RUN mkdir /var/www/moncv/

#Copie du dossier site dans le nouveau MonCV sur docker
COPY ./site /var/www/moncv/

#Définir les permissions 
RUN chown -R www-data:www-data /var/www/moncv

#Copie du VirtualHost
COPY ./moncv.conf /etc/apache2/sites-available/moncv.conf

#Désactivation de 000-defaut.conf et initialisation du nouveau site puis réactivation de 000-default
RUN a2dissite 000-default.conf && \ 
a2ensite moncv.conf && \ 
a2enmod rewrite 

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
