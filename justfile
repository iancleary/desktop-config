# list recipes
help:
  just --list

now := `date +"%Y-%m-%d_%H.%M.%S"`
hostname := `uname -n`

# echo hostname (uname -n)
echo:
  @echo "{{ hostname }}"

# Copy the nixos config in repo to /etc/nixos
update:
  bash config.sh "{{ hostname }}"

lock:
  sudo cp /etc/nixos/flake.lock flake.lock


# Run `sudo nixos-rebuild switch`
switch:
  sudo nixos-rebuild switch
  just lock

# Run `sudo nixos-rebuild switch --upgrade` to upgrade channels
upgrade:
  sudo nixos-rebuild switch --upgrade

# garbage collect
gc:
  nix-store --gc

# Reboot
reboot:
  sudo reboot now

fwupd:
  @echo "run 'fwupdmgr refresh' to refresh firmware list"
  @echo "run 'fwupdmgr get-updates' to check for updates"
  @echo "Run 'fwupdmgr update' to update firmware"

version VERSION:
  @echo "{{ VERSION }}"

version-upgrade VERSION:
  sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-{{VERSION}}.tar.gz home-manager
  sudo nix-channel --update
  sudo  nix-channel --add https://channels.nixos.org/nixos-{{VERSION}} nixos
  nixos-rebuild switch --upgrade
