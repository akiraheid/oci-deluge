#!/bin/bash

# Install deluge container app

set -e

APP=~/.local/share/applications
BIN=~/.local/bin
CFG=~/.config/deluge

mkdir -p $APP $BIN $CFG

# Install the executable
cp podman/deluge $BIN/

# Install the configuration file
cp core.conf $CFG/

# Install desktop shortcut
cp deluge.desktop $APP/

if [ -z "`which deluge`" ]; then
	echo "Add '~/.local/bin' to your PATH and restart your computer"
fi

echo "Done!"
