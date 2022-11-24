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
sudo mkdir -p "/etc/nixos/editors"
sudo ln -f "editors/vscode.nix" "/etc/nixos/editors/vscode.nix"
sudo mkdir -p "/etc/nixos/modules"
sudo ln -f "modules/cli_utils.nix" "/etc/nixos/modules/cli_utils.nix"
sudo ln -f "modules/desktop_utils.nix" "/etc/nixos/modules/desktop_utils.nix"
sudo ln -f "modules/sh.nix" "/etc/nixos/modules/sh.nix"
sudo ln -f "modules/tailscale.nix" "/etc/nixos/modules/tailscale.nix"

