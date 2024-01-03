# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.users.icleary = {
    home.stateVersion = "23.11";
    imports = [
      ./common.nix
      ./xfce # folder
    ];
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.icleary = {
    isNormalUser = true;
    description = "icleary";
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxsf" ];
  };
}
