FROM ubuntu:22.04
WORKDIR /app
ENV IP=192.168.0.199
RUN echo 'root:root' | chpasswd
RUN apt update 
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session
RUN apt install strongswan strongswan-pki libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-extra-plugins -y
RUN mkdir /app/env
RUN mkdir /app/pki
RUN mkdir /app/pki/private
RUN mkdir /app/pki/cacerts
RUN mkdir /app/pki/certs
RUN chmod 700 /app/pki
RUN ["systemctl", "enable", "strongswan-starter"]
EXPOSE 500/udp 4500/udp
# ENTRYPOINT /ect/init.d/strongswan-starter start && /bin/bash
ENTRYPOINT ["/sbin/init"]
CMD ["bash start.sh"]