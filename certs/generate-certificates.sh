#!/bin/bash

function generate_CA () {
   SUBJECT_CA="/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$CA_OU/CN=$CA_CN"
   echo "$SUBJECT_CA"

   openssl req -x509 -nodes -sha256 -newkey rsa:2048 -subj "$SUBJECT_CA" -days 3652 -keyout ca.key -out ca.crt
}

function generate_server () {
   echo "Server Common Name?"
   read server_common_name

   SUBJECT_SERVER="/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$SERVER_OU/CN=$server_common_name"
   echo "$SUBJECT_SERVER"

   openssl req -nodes -sha256 -new -subj "$SUBJECT_SERVER" -keyout server.key -out server.csr
   openssl x509 -req -sha256 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 365
}

function generate_client () {
   echo "Client Common Name?"
   read client_common_name

   SUBJECT_CLIENT="/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$CLIENT_OU/CN=$client_common_name"
   echo "$SUBJECT_CLIENT"

   openssl req -new -nodes -sha256 -subj "$SUBJECT_CLIENT" -out $client_common_name.csr -keyout $client_common_name.key
   openssl x509 -req -sha256 -in $client_common_name.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $client_common_name.crt -days 365
}

cd certs

$1
