#!/bin/bash
if [ -n "${DB_SSL_CA_CERT}" ]; then
  export DB_SSL=mysql-ca.pem
  echo "${DB_SSL_CA_CERT}" > ${DB_SSL}
fi
