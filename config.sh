HOST=`hostname`
if [[ ! -z "$1" ]]; then
	HOST=$1
fi

if [[ ! -e "hosts/$HOST.nix" ]]; then
	echo "missing hosts/$HOST.nix" >&2
	exit 1
fi

function clean_local_folder() {
	sudo rm -rf "/etc/nixos/$1"
}

function cp_local_folder() {
	sudo cp -r "$1" "/etc/nixos/$1"
}


sudo cp "hosts/$HOST.nix" "/etc/nixos/configuration.nix"

clean_local_folder "modules"
clean_local_folder "users"

cp_local_folder "modules"
cp_local_folder "users"