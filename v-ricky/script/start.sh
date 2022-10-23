#/bin/bash

echo "Bash for start"

mkdir -p /app/conf

[ -f /app/conf/ipsec.conf ] && cp /app/conf/ipsec.conf /etc/ipsec.conf || cp /etc/ipsec.conf /app/conf/ipsec.conf
[ -f /app/conf/ipsec.secrets ] && cp /app/conf/ipsec.secrets /etc/ipsec.secrets || cp /etc/ipsec.secrets /app/conf/ipsec.secrets

exec /sbin/init
