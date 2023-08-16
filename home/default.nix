# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

{
  include = [
    ./gnome.nix
  ];
  users.users."${config.variables.username}" = {
    home = "/home/${config.variables.username}";
    isNormalUser = true;
    description = config.variables.username;
    extraGroups = [
      config.variables.username
      "wheel"
      "docker"
      "vboxsf"
    ];
  }
    }
