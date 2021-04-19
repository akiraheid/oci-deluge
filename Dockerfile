# Usage
# podman run -d --rm \
#	--name deluge \
#	-e DISPLAY=unix$DISPLAY \
#	-v $HOME/.config/deluge/:/config/ \
#	-v $HOME/Downloads/deluge/:/downloads/ \
#	-v /tmp/.X11-unix:/tmp/.X11-unix \
#	localhost/deluge
#
FROM alpine:edge
LABEL maintainer "Akira Heid <akira710@protonmail.com>"

RUN apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
	--no-cache \
	--no-progress \
	adwaita-icon-theme \
	deluge \
	gtk+3.0 \
	py3-setuptools

ENTRYPOINT ["deluge"]
