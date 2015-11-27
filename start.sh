#!/bin/sh

if [ ! -e "/.setup" ] || [ "/etc/fusiondirectory/fusiondirectory.conf" -nt "/.setup" ]; then
    yes Yes | fusiondirectory-setup --check-config
    touch /.setup
fi

. /etc/apache2/envvars
/usr/sbin/apache2 -D FOREGROUND
