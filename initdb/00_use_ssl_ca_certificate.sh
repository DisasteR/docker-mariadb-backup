#!/bin/bash

if [ -n "${DB_SSL_CA_CERT}" ]; then
  >&2 echo "found SSL certificate in DB_SSL_CA_CERT, using that for the Mariadb CA"
  export DB_SSL=/mysql-ca.pem
  if [ -e ${DB_SSL} ]; then
    echo "File ${DB_SSL} already exists, ignoring DB_SSL_CA_CERT."
  else
    echo "${DB_SSL_CA_CERT}" | sed -e 's,\\n,\n,g' > ${DB_SSL}
  fi
fi
