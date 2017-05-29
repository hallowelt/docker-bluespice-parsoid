FROM node:6

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git-core
RUN git clone https://gerrit.wikimedia.org/r/p/mediawiki/services/parsoid /opt/parsoid 
RUN cd /opt/parsoid && npm install && npm test && cp config.example.yaml config.yaml
RUN npm install pm2 -g
CMD node /opt/parsoid/bin/server.js -c /opt/parsoid/config/config.yaml
EXPOSE 8000
VOLUME /opt/parsoid/config
