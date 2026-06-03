FROM httpd:2.4

RUN apt-get update && apt-get install -y gettext-base

COPY index.html /usr/local/apache2/htdocs/index.html
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]