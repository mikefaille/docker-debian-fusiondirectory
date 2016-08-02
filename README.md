# This repository is unmaintened.
Prefer this fork : This repository is unmaintened. Prefer this fork : https://github.com/ClubCedille/docker-debian-fusiondirectory 

# fusiondirectory
FusionDirectory docker image

docker run -td -v /root/etc/ldap:/etc/ldap -e SLAPD_PASSWORD="xxxxxxxxxxx" -e SLAPD_DOMAIN=xxxxxxxxx.xx -e SLAPD_ORGANIZATION=xxxxx \
	--name ldap oondeo/fusiondirectory-ldap

docker run -td -e LDAP_DOMAIN=xxxx -e LDAP_PASSWORD="xxxxxx" -e FUSIONDIRECTORY_PASSWORD="xxxxxx" --link ldap:ldap \
	-e VIRTUAL_HOST="ldap.domain.co" -e VIRTUAL_PORT=80 -e LETSENCRYPT_HOST="ldap.domain.co" -e LETSENCRYPT_EMAIL="info@oondeo.es" \
	--name fusiondirectory oondeo/fusiondirectory
