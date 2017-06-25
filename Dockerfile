FROM debian:latest
MAINTAINER Kike Gil (mahoul@gmail.com)

ENV PS1 '\A \u \w \$ '
ENV DEBIAN_FRONTEND noninteractive

COPY start_mpd.sh /start_mpd.sh
COPY mpd.conf /etc/mpd.conf.custom

RUN apt-get clean && \
apt-get update && \
apt-get install -y mpc mpd bash vim && \
mkdir -p /mpd-music /mpd-playlists && \
chown -R mpd:audio /mpd* && \
mv /etc/mpd.conf /etc/mpd.conf.debian && \
mv /etc/mpd.conf.custom /etc/mpd.conf && \
chmod +x /start_mpd.sh 

CMD ["/start_mpd.sh"]

VOLUME /mpd-music
VOLUME /mpd-playlists

WORKDIR /

EXPOSE 6600 8000

SHELL ["/bin/bash", "-c"]

