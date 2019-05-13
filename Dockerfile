FROM node:10-alpine

WORKDIR /opt/parsoid

RUN wget https://buildservice.bluespice.com/webservices/REL1_31/parsoid.tar.gz; \
	tar xf parsoid.tar.gz; \
	rm parsoid.tar.gz; \
	mv parsoid/* .; \
	rm -rf parsoid

COPY parsoid/config.yaml .
COPY parsoid/localsettings.js .

EXPOSE 8000

CMD [ "node", "bin/server.js" ]

