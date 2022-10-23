pki --gen --type rsa --size 4096 --outform pem > /app/pki/private/ca-key.pem
pki --self --ca --lifetime 3650 --in /app/pki/private/ca-key.pem --type rsa --dn "CN=servisofts" --outform pem > /app/pki/cacerts/ca-cert.pem
pki --gen --type rsa --size 4096 --outform pem > /app/pki/private/server-key.pem
pki --pub --in /app/pki/private/server-key.pem --type rsa \
    | pki --issue --lifetime 1825 \
        --cacert /app/pki/cacerts/ca-cert.pem \
        --cakey /app/pki/private/ca-key.pem \
        --dn "CN=$IP" --san @$IP --san $IP \
        --flag serverAuth --flag ikeIntermediate --outform pem \
    >  /app/pki/certs/server-cert.pem
cp -r /app/pki/* /etc/ipsec.d/