HOST=`hostname`
if [[ ! -z "$1" ]]; then
	HOST=$1
fi

if [[ ! -e "hosts/$HOST" ]]; then
	echo "missing hosts/$HOST folder! exiting..." >&2
	exit 1
fi

function clean_local_folder() {
	sudo rm -rf "/etc/nixos/$1"
}

function cp_local_folder() {
	sudo cp -r "$1" "/etc/nixos/$1"
}


clean_local_folder "hosts"
clean_local_folder "hardware-configuration"
clean_local_folder "modules"
clean_local_folder "users"
clean_local_folder "home"
sudo rm "/etc/nixos/configuration.nix"
sudo rm "/etc/nixos/hardware-configuration.nix"

cp_local_folder "modules"
cp_local_folder "home"
sudo cp "hosts/$HOST/configuration.nix" "/etc/nixos/configuration.nix"
sudo cp "hosts/$HOST/hardware-configuration.nix" "/etc/nixos/hardware-configuration.nix"
sudo cp "flake.nix" "/etc/nixos/flake.nix"
