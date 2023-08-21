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

  # # https://github.com/NixOS/nixpkgs/issues/206630#issuecomment-1518696676
  services.xserver.displayManager.importedVariables = [
    "XDG_SESSION_TYPE"
    "XDG_CURRENT_DESKTOP"
    "XDG_SESSION_DESKTOP"
  ];

  environment.systemPackages = with pkgs; [
    ## To get systray icons, install the related gnome shell extension
    gnomeExtensions.appindicator
    xdg-desktop-portal-gnome
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };

  # Install Flatpak
  services.flatpak.enable = true;

  # Gnome Keyring
  services.gnome.gnome-keyring.enable = true;

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
