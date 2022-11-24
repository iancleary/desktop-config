#!/usr/bin/env bash

HOST=`hostname`
if [[ ! -z "$1" ]]; then
	HOST=$1
fi

if [[ ! -e "hosts/$HOST/configuration.nix" ]] || [[ ! -e "hosts/$HOST/hardware-configuration.nix" ]]; then
	echo "missing $HOST.nix or $HOST-hardware.nix" >&2
	exit 1
fi

sudo ln -f "hosts/$HOST/configuration.nix" "/etc/nixos/configuration.nix"
sudo ln -f "hosts/$HOST/hardware-configuration.nix" "/etc/nixos/hardware-configuration.nix"
sudo mkdir "/etc/nixos/editors"
sudo ln -f "editors/vscode.nix" "/etc/nixos/editors/vscode.nix"