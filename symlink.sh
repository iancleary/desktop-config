#!/usr/bin/env bash

HOST=`hostname`
if [[ ! -z "$1" ]]; then
	HOST=$1
fi

if [[ ! -e "hosts/$HOST/configuration.nix" ]] || [[ ! -e "hosts/$HOST/hardware-configuration.nix" ]]; then
	echo "missing $HOST.nix or $HOST-hardware.nix" >&2
	exit 1
fi

function make_dir() {
	sudo mkdir -p "/etc/nixos/$1"
}

function make_link() {
	sudo ln -f "$1" "/etc/nixos/$1"
}


sudo ln -f "hosts/$HOST/configuration.nix" "/etc/nixos/configuration.nix"
sudo ln -f "hosts/$HOST/hardware-configuration.nix" "/etc/nixos/hardware-configuration.nix"
sudo ln -f "hosts/$HOST/home_manager.nix" "/etc/nixos/home_manager.nix"

make_dir "editors"
make_dir "modules"

make_link "modules/allow_unfree.nix"
make_link "modules/bootloader.nix"
make_link "modules/cli_packages.nix"
make_link "modules/desktop_packages.nix"
make_link "modules/gnome_and_x11.nix"
make_link "modules/install_docker.nix"
make_link "modules/install_flatpak.nix"
make_link "modules/install_tailscale.nix"
make_link "modules/networking.nix"
make_link "modules/services_printing.nix"
make_link "modules/services_sound.nix"
make_link "modules/sw_development.nix"
make_link "modules/terminal_customization.nix"
make_link "modules/time_and_localization.nix"
make_link "modules/user_accounts.nix"
make_link "editors/vscode.nix"
