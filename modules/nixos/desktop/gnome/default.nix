# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
 
  services = {
    # Install Flatpak
    flatpak.enable = true;
     # Enable the GNOME Desktop Environment.
    # https://nixos.wiki/wiki/GNOME
    xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;

        # https://github.com/NixOS/nixpkgs/issues/206630#issuecomment-1518696676
        importedVariables = [
          "XDG_SESSION_TYPE"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_DESKTOP"
        ];
      };
      desktopManager.gnome.enable = true;

      # Excluding some GNOME applications from the default install
      excludePackages = with pkgs; [
        xterm
      ];
    };

    # Gnome Keyring
    gnome.gnome-keyring.enable = true;

    # Ensure gnome-settings-daemon udev rules are enabled :
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  environment = {
    systemPackages = with pkgs; [
      ## To get systray icons, install the related gnome shell extension
      gnomeExtensions.appindicator
      xdg-desktop-portal-gnome
    ];
    # Excluding some GNOME applications from the default install
    gnome.excludePackages = (with pkgs; [
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
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };
}
