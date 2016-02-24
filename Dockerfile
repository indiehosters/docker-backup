FROM indiehosters/duplicity

RUN apt-get update \
 && apt-get install -y --force-yes apt-transport-https ca-certificates \
 && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
 && echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list \
 && apt-get update \
 && apt-get install -y -q docker-engine=1.8.3-0~jessie

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
