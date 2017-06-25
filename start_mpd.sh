#!/bin/bash

set -x

startPlayList(){

	while [ ! -f /var/lib/mpd/tag_cache ]; do
		sleep .1
	done

	if [ -f /mpd-playlists/Favorites.m3u ]; then
		mpc clear
		mpc update
		mpc load Favorites 
		mpc play
		return 0
	fi

}

sed -i -e "s#^mpd.*#mpd:x:$MPD_UID:$MPD_GID:mpd:/var/lib/mpd:/sbin/nologin#" /etc/passwd
sed -i -e "s#^audio.*#audio:x:$MPD_GID:mpd#g" /etc/group

[ ! -d /var/lib/mpd ] && mkdir -p /var/lib/mpd
[ ! -d /run/mpd ] && mkdir -p /run/mpd

chown -R mpd:audio /var/lib/mpd* /run/mpd*

startPlayList &

mpd --no-daemon --stderr -v


