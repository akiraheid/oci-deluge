name=deluge
config=${HOME}/.config/deluge
downloads=${HOME}/Downloads/deluge

image:
	podman build -t $(name) .

run:
	bash podman/deluge

.PHONY: image run
