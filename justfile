# list recipes
help:
  just --list

now := `date +"%Y-%m-%d_%H.%M.%S"`
hostname := `uname -n`

# echo hostname (uname -n)
echo:
  @echo "{{ hostname }}"

# Update the flake lock file
update:
  nix flake update

# Run `sudo nixos-rebuild switch` (only for nixos)
switch:
  echo "nix-flatpak initial build may take a while..."
  sudo nixos-rebuild switch --flake .

# Update the configuration using home-manager (non-nixos or WSL)
home-manager:
  home-manager switch --flake .#wsl

# garbage collect
gc:
  nix-store --gc

# prompt/echo for fwupd commands
fwupd:
  @echo "run 'fwupdmgr refresh' to refresh firmware list"
  @echo "run 'fwupdmgr get-updates' to check for updates"
  @echo "Run 'fwupdmgr update' to update firmware"


# Lint all files (similar to GitHub Actions), setup nix-shell
lint:
  nix develop --accept-flake-config .#lint

# format all the files, when in a nix-shell
format:
  nixpkgs-fmt .

# check all files (similar to GitHub Actions), when in a nix-shell
check:
  actionlint
  yamllint .
  selene .
  stylua --check .
  statix check
  nixpkgs-fmt --check .

# Check flake evaluation
flake:
  nix flake check --no-build --all-systems

# Open the github repo in default web browser
open:
  xdg-open https://github.com/iancleary/nixos-config & disown

