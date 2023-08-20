# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  # https://nixos.wiki/wiki/GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Gnome Keyring
  services.gnome.gnome-keyring.enable = true;

  # Systray Icons
  ## To get systray icons, install the related gnome shell extension
  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  ## And ensure gnome-settings-daemon udev rules are enabled :
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Excluding some GNOME applications from the default install
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  services.xserver.excludePackages = (with pkgs; [
    xterm
  ]);
}
