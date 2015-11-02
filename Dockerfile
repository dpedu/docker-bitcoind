FROM ubuntu:trusty

RUN apt-get update && \
    apt-get install -y supervisor software-properties-common && \
    add-apt-repository -y ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get install -y bitcoind && \
    apt-get clean && \
    useradd -m crypto && \
    su -c "mkdir /home/crypto/bitcoin/" crypto && \
    rm -rf /var/lib/apt/lists/*

ADD bitcoin.conf /home/crypto/bitcoin.conf
ADD bitcoind.conf /etc/supervisor/conf.d/bitcoind.conf

VOLUME /home/crypto/bitcoin/
EXPOSE 8332 8333

ENTRYPOINT supervisord
