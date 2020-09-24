FROM          alpine:3.12.0
MAINTAINER    Laur Aliste

ENV LANG=C.UTF-8

# check docker versions from https://download.docker.com/linux/static/stable/x86_64/

#ENV DOCKER_VERSION=18.06.3-ce
ENV BORG_VERSION=1.1.13-r1

ADD scripts/* /usr/local/sbin/

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
        curl bash mysql-client ca-certificates \
        borgbackup=$BORG_VERSION \
        docker-cli && \
    chown -R root:root /usr/local/sbin/ && \
    chmod -R 755 /usr/local/sbin/ && \
    ln -s /usr/local/sbin/setup.sh /setup.sh && \
    ln -s /usr/local/sbin/backup.sh /backup.sh && \
    ln -s /usr/local/sbin/scripts_common.sh /scripts_common.sh

# TODO: prolly need to add these apk pacakges:
#openssh-keygen
#openssh-client

#CMD ["/entry.sh"]
ENTRYPOINT ["/usr/local/sbin/entry.sh"]

