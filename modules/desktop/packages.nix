# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.sushi
    # guake
    linssid
    # jetbrains.pycharm-community
    #
    # vscode-fhs # vscode with FHS (File Hierarchy System) layout
    # Switched to Flatpak and Devcontainers
    # https://github.com/flathub/com.visualstudio.code/issues/203#issue-802483421
  ];

  # Run Vscode under Wayland
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
