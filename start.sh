#!/bin/sh
set -euo

if [ $LDAP_SERVER == "configure-me"]
then
    echo "Variable named LDAP_SERVER is not set.
It must countain the address of your ldap server.
For example :

docker run -ti -p 10080:80  -e LDAP_SERVER= fusiondirectory"
    exit 127
fi

export LDAP_DOMAIN_DC="dc=$(echo ${SLDAP_DOMAIN} | sed  's/\./,dc=/g')"

envsubst < /fusiondirectory.conf > /etc/fusiondirectory/fusiondirectory.conf

if [ ! -e "/etc/fusiondirectory/fusionready" ]; then
    yes Yes | fusiondirectory-setup --check-config
    fusiondirectory-setup --yes --check-ldap << EOF
admin
$FUSIONDIRECTORY_PASSWORD
$FUSIONDIRECTORY_PASSWORD
EOF
    touch /etc/fusiondirectory/fusionready
fi


gosu www-data sh -c ". /etc/apache2/envvars && /usr/sbin/apache2 -D FOREGROUND"
