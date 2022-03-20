FROM debian:buster

COPY ./bin/ttyd /usr/bin/
ADD ./entrypoint.sh /

# install ssh service
RUN apt-get update && \
    apt-get -y install --no-install-recommends --no-install-suggests \
        openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/sshd && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    echo "root:origin123456" | chpasswd && \
    chmod +x /usr/bin/ttyd && \
    chmod +x /entrypoint.sh

WORKDIR /root

ENTRYPOINT ["/entrypoint.sh"] 
