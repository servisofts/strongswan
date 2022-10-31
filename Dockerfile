FROM ubuntu:22.04
WORKDIR /app
RUN echo 'root:root' | chpasswd
RUN apt update 
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session
RUN apt install strongswan strongswan-pki libcharon-extra-plugins libcharon-extauth-plugins libstrongswan-extra-plugins -y
RUN apt install ufw -y
EXPOSE 500/udp 4500/udp
COPY ["./script", "/app/script"]
RUN chmod +x -R /app/script/
ENV PATH="$PATH:/app/script"
RUN ["systemctl", "enable", "strongswan-starter"]
ENTRYPOINT [ "/bin/bash" ] 
CMD ["start"]
