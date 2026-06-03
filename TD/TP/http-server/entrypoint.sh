#!/bin/sh

envsubst < /usr/local/apache2/conf/httpd.conf.template > /usr/local/apache2/conf/httpd.conf

httpd-foreground