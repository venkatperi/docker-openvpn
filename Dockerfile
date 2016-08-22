FROM quay.io/justcontainers/base


# Install openvpn
RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -q && \
    apt-get install -qy --no-install-recommends iptables openvpn \ 
      $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    addgroup --system vpn

ENV OPENVPN_CONF_FILE=/vpn/vpn.conf 

COPY rootfs /

VOLUME ["/vpn"]

ENTRYPOINT ["/init"]
