## NOTE: to retain configuration; mount a Docker volume, or use a bind-mount, on /var/lib/zerotier-one

FROM debian:bullseye-slim as builder

## Supports x86_64, x86, arm, and arm64

RUN apt-get update && apt-get install -y curl gnupg

RUN curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | bash; fi

#RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 0x1657198823e52a61  && \
#    echo "deb http://download.zerotier.com/debian/buster buster main" > /etc/apt/sources.list.d/zerotier.list

RUN apt-get update && apt-get install -y zerotier-one=1.8.9
RUN apt-get update && apt-get install -y procps
FROM debian:bullseye-slim
LABEL version="1.8.9"
LABEL description="Containerized ZeroTier-Moon for use on CoreOS or other Docker-only Linux hosts."

# ZeroTier relies on UDP port 9993
EXPOSE 9993/udp

RUN mkdir -p /var/lib/zerotier-one
COPY --from=builder /usr/sbin/zerotier-cli /usr/sbin/zerotier-cli
COPY --from=builder /usr/sbin/zerotier-idtool /usr/sbin/zerotier-idtool
COPY --from=builder /usr/sbin/zerotier-one /usr/sbin/zerotier-one
COPY startup.sh /startup.sh
RUN chmod 0755 /startup.sh
ENTRYPOINT ["/startup.sh"]
CMD ["zerotier-one"]
