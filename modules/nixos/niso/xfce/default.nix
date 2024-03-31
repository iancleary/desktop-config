# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  services = {
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      displayManager = {
        lightdm = {
          enable = true;
          greeters.slick = {
            enable = true;
            theme.name = "Zukitre-dark";
          };
        };
      };
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
      displayManager.defaultSession = "xfce";
    };
  };

  environment.systemPackages = with pkgs; [
    elementary-xfce-icon-theme
    gnome.file-roller
    gnome.gnome-disk-utility
    pavucontrol
    xfce.catfish
    xfce.gigolo
    xfce.orage
    xfce.xfburn
    xfce.xfce4-appfinder
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-dict
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-genmon-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-panel
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-xkb-plugin
    xfce.xfdashboard
    zuki-themes
    # xdg-desktop-portal-xfce
  ];

  xdg.portal = {
    enable = true;
    # extraPortals = with pkgs; [
    # xdg-desktop-portal-xfce
    # ];
  };

  # Install Flatpak
  services.flatpak.enable = true;
}
