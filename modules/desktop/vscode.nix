# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config.allowUnfree = true;};
in {
  environment.systemPackages = [ 
    unstable.vscode-fhs # vscode with FHS (File Hierarchy System) layout
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
