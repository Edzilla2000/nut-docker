FROM ubuntu:20.04

LABEL maintainer="Jean Cardona"
LABEL description="Nut Server in Docker"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
   nut nut-snmp snmp-mibs-downloader snmp\
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

RUN chown root:root /var/run/nut && chmod 770 /var/run/nut 

RUN echo "LISTEN 0.0.0.0 3493" > /etc/nut/upsd.conf
RUN echo "MODE=netserver" > /etc/nut/nut.conf

EXPOSE 3493
COPY ./entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT /usr/local/bin/entrypoint.sh
