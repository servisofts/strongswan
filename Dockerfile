FROM ubuntu:22.04
WORKDIR /app
ENV IP=192.168.0.199
RUN apt update 
RUN apt install systemd -y
RUN apt install strongswan strongswan-pki libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-extra-plugins -y
RUN mkdir /app/pki
RUN mkdir /app/pki/private
RUN mkdir /app/pki/cacerts
RUN mkdir /app/pki/certs
RUN chmod 700 /app/pki
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

COPY ["./ipsec.conf", "/etc/ipsec.conf"]
COPY ["./ipsec.secrets", "/etc/ipsec.secrets"]
COPY ["./start.sh", "start.sh"]
EXPOSE 500 4500
RUN ["sh", "start.sh"]


