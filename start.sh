#!/bin/sh

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
