#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
    echo -e "Sorry, you need to run this as root!"
    exit 2
fi

read -n1 -r -p "Press any key to start ..."
clear

# Default Stunnel Value
COUNTRY="PH"
STATE="Misamis Occidental"
CITY="Ozamiz"
ORGANIZATION="JayDee Solutions"
ORGANIZATIONAL_UNIT=""
COMMON_NAME="OZMZVPN"
EMAIL="johndave10010001010000@gmail.com"
PASSWORD="QWRtaW5Vbmtub3duU2VjcmV0UVdSdGFXNVZibXR1YjNkdVUyVmpjbVY"

# Default SSH, OpenVPN, Stunnel Ports values
DEFAULT_SSH_PORT="22"
DEFAULT_SSH_SSL_PORT="443"
DEFAULT_OPENVPN_PORT="1194"
DEFAULT_OPENVPN_SSL_PORT="587"

read -p "Enter SSH Port: " -e -i $DEFAULT_SSH_PORT SSH_PORT
while [[ "$SSH_PORT" == "" ]]
do
    read -p "Enter SSH Port:: " -e -i $DEFAULT_SSH_PORT SSH_PORT
done

read -p "Enter SSH SSL Port: " -e -i $DEFAULT_SSH_SSL_PORT SSH_SSL_PORT
while [[ "$SSH_SSL_PORT" == "" ]]
do
    read -p "Enter SSH SSL Port: " -e -i $DEFAULT_SSH_SSL_PORT SSH_SSL_PORT
done

read -p "Enter OpenVPN Port: " -e -i $DEFAULT_OPENVPN_PORT OPENVPN_PORT
while [[ "$OPENVPN_PORT" == "" ]]
do
    read -p "Enter OpenVPN Port: " -e -i $DEFAULT_OPENVPN_PORT OPENVPN_PORT
done

read -p "Enter OpenVPN SSL Port: " -e -i $DEFAULT_OPENVPN_SSL_PORT OPENVPN_SSL_PORT
while [[ "$OPENVPN_SSL_PORT" == "" ]]
do
    read -p "Enter OpenVPN SSL Port: " -e -i $DEFAULT_OPENVPN_SSL_PORT OPENVPN_SSL_PORT
done

apt-get -y update
apt-get -y install stunnel4 openssl

echo "cert = /etc/stunnel/stunnel.pem
[ssh] 
accept = $SSH_SSL_PORT
connect = 127.0.0.1:$SSH_PORT

[openvpn]
accept = $OPENVPN_SSL_PORT
connect = 127.0.0.1:$OPENVPN_PORT" > /etc/stunnel/stunnel.conf

openssl genrsa -out key.pem 2048 && openssl req -new -x509 -key key.pem -out cert.pem -days 1095 -passin pass:$PASSWORD \
    -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$ORGANIZATIONAL_UNIT/CN=$COMMON_NAME/emailAddress=$EMAIL"

cat key.pem cert.pem > /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4

echo "Successfully installed SSL over SSH & OpenVPN!"
