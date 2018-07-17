# docker-bluespice-parsoid

## MediaWiki LocalSettings config
Install instruction for VisualEditor can be found here: https://www.mediawiki.org/wiki/Extension:VisualEditor

## Run parsoid docker
```
git clone https://github.com/hallowelt/docker-bluespice-parsoid.git
cd docker-bluespice-parsoid
docker build -t parsoid .
docker run -d -v $(pwd):/etc/parsoid/config -p=8000:8000 parsoid
```
If you wish to run with letsencrypt certificate:
````
docker run -d -v $(pwd):/etc/parsoid/config -p=8000:8000 -p=8001:8001 parsoid
````

## Enable docker container at boot for systemd

* Edit /etc/systemd/system/docker-container@parsoid.service:
```
[Unit]
Description=Docker Container %I
Requires=docker.service
After=docker.service

[Service]
ExecStart=
ExecStart=/usr/bin/docker run -v /etc/mediawiki/parsoid:/opt/parsoid/config --name %i -p 8000:8000 parsoid
ExecStopPost=/usr/bin/docker rm -f %i

[Install]
WantedBy=default.target
```
* Copy config.yaml to /etc/mediawiki/parsoid/config.yaml
```
mkdir -p /etc/mediawiki/parsoid/
cp config.yaml /etc/mediawiki/parsoid/config.yaml
```
* Restart systemd and enable service
```
systemctl daemon-reload
sudo systemctl start docker-container@parsoid.service
```


