#
FROM alpine:3.17

RUN apk add --update --no-cache \
        openldap openldap-back-mdb openldap-clients \
        openldap-passwd-pbkdf2 openldap-overlay-memberof \
        openldap-overlay-ppolicy openldap-overlay-refint \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /ldap

EXPOSE 389
EXPOSE 636

COPY ldap/ /ldap/

COPY docker-entrypoint.sh /
RUN chmod +xr /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]