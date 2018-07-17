FROM node:8

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y
RUN apt-get install -y git-core vim stunnel4

RUN sed -i s/ENABLED=0/ENABLED=1/g /etc/default/stunnel4
RUN echo "cert = /etc/parsoid/ssl/fullchain.pem" > /etc/stunnel/parsoid.conf
RUN echo "key = /etc/parsoid/ssl/privkey.pem" >> /etc/stunnel/parsoid.conf
RUN echo "" >> /etc/stunnel/parsoid.conf
RUN echo "[parsoid]" >> /etc/stunnel/parsoid.conf
RUN echo "accept  = 8001" >> /etc/stunnel/parsoid.conf
RUN echo "connect = 8000" >> /etc/stunnel/parsoid.conf

RUN git clone https://gerrit.wikimedia.org/r/p/mediawiki/services/parsoid /opt/parsoid

RUN cd /opt/parsoid; npm install; npm test

RUN mkdir -p /etc/parsoid/config
RUN mkdir -p /etc/parsoid/ssl

RUN cp /opt/parsoid/config.example.yaml /etc/parsoid/config/config.yaml

CMD service stunnel4 start; node /opt/parsoid/bin/server.js -c /etc/parsoid/config/config.yaml

EXPOSE 8000
EXPOSE 8001
VOLUME /etc/parsoid/config
VOLUME /etc/parsoid/ssl
