FROM ubuntu:22.04
WORKDIR /app
RUN echo 'root:root' | chpasswd
RUN apt update 
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session
RUN apt install strongswan strongswan-pki libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-extra-plugins -y
EXPOSE 500/udp 4500/udp
COPY ["./script", "/app/script"]
RUN ["systemctl", "enable", "strongswan-starter"]
CMD ["bash","/app/script/start.sh"]
