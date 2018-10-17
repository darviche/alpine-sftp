FROM alpine:latest

RUN apk add --upgrade \
    bash \
    shadow \
    openssh \
    openssh-sftp-server \
    && rm -rf /var/cache/apk/* \
    && sed -i 's/GROUP=1000/GROUP=100/' /etc/default/useradd \
    && mkdir -p /var/run/sshd \
    && rm -f /etc/ssh/ssh_host_*key*

COPY sshd_config /etc/ssh/sshd_config
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/docker-entrypoint.sh"]
