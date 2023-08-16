# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, variables, ... }:

{
  include = [
    ./gnome.nix
  ];
  users.users."${variables.username}" = {
    home = "/home/${variables.username}";
    isNormalUser = true;
    description = variables.username;
    extraGroups = [
      variables.username
      "wheel"
      "docker"
      "vboxsf"
    ];
  }
    }
