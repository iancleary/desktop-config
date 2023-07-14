# https://github.com/nix-community/nix-direnv#via-home-manager
# Optional: To protect your nix-shell against garbage collection 
# you also need to add these options to your Nix configuration.
# If you are on NixOS also add the following lines to your
# /etc/nixos/configuration.nix:

{ pkgs, ... }: {
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}