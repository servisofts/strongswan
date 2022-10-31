cp /env/ipsec.conf /etc/ 
cp /env/ipsec.secrets /etc/

RUN pki --gen --type rsa --size 4096 --outform pem > /app/pki/private/ca-key.pem
RUN pki --self --ca --lifetime 3650 --in /app/pki/private/ca-key.pem --type rsa --dn "CN=servisofts" --outform pem > /app/pki/cacerts/ca-cert.pem
RUN pki --gen --type rsa --size 4096 --outform pem > /app/pki/private/server-key.pem
RUN pki --pub --in /app/pki/private/server-key.pem --type rsa \
    | pki --issue --lifetime 1825 \
        --cacert /app/pki/cacerts/ca-cert.pem \
        --cakey /app/pki/private/ca-key.pem \
        --dn "CN=$IP" --san @$IP --san $IP \
        --flag serverAuth --flag ikeIntermediate --outform pem \
    >  /app/pki/certs/server-cert.pem
RUN cp -r /app/pki/* /etc/ipsec.d/