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

# Update the flake lock file
flake:
  nix flake update

# Copy the flake lock file from /etc/nixos into the repo
lock:
  sudo cp /etc/nixos/flake.lock flake.lock

# Run `sudo nixos-rebuild switch`
switch:
  sudo nixos-rebuild switch
  just lock

# Run `sudo nixos-rebuild switch --upgrade` to upgrade channels
upgrade: update
  sudo nixos-rebuild switch --upgrade

# garbage collect
gc:
  nix-store --gc

# Reboot
reboot:
  sudo reboot now

# prompt/echo for fwupd commands
fwupd:
  @echo "run 'fwupdmgr refresh' to refresh firmware list"
  @echo "run 'fwupdmgr get-updates' to check for updates"
  @echo "Run 'fwupdmgr update' to update firmware"

# setup pre-commit hooks
pre-commit:
  @echo "If this fails, run devbox shell and run 'just pre-commit' again"
  pre-commit install

# Lint all files according to pre-commit hooks
lint:
  pre-commit run --all-files

# Open the github repo in default web browser
open:
  xdg-open https://github.com/iancleary/nixos-config & disown

# Setup flatpak applications
flatpak:
  bash flatpak/setup.sh
