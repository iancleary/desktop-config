# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Install Flatpak
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    hyprpaper # wallpaper utility
    kitty # terminal emulator
    waybar # wayland bar
    wofi # app launcher

    # polkit-kde-agent
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  # Service to start
  # copied from https://discourse.nixos.org/t/ulauncher-and-the-debugging-journey/13141/5?u=iancleary
  # modified to use pkg-unstable instead of pkgs
  # names of wantedBy targets and after services are different for user services
  # launches with CTRL+SPACE
  systemd.services.hyprland = {
    enable = true;
    description = "Start Hyprland";
    # script = "/run/current-system/sw/bin/ulauncher --hide-window";
    script = "/run/current-system/sw/bin/Hyprland";

    documentation = [ "https://github.com/hyperwm/Hyprland" ];
    wantedBy = [ "multi-user.target" ];
  };
}
