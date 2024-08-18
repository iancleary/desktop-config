{ config, inputs, lib, pkgs, ... }:

let
  cfg = config.mySystem.hyprland;
in
{
  options.mySystem.hyprland = {
    enable = lib.mkEnableOption "hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };

    # Optional, hint electron apps to use wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    security = {
      # Gnome keyring
      polkit.enable = true;
      # swaylock
      # https://discourse.nixos.org/t/swaylock-wont-unlock/27275
      pam.services.swaylock.fprintAuth = false;
    };
    services = {
      gnome.gnome-keyring.enable = true;

      flatpak.enable = true;

      # Bluetooth
      blueman.enable = true;


      # https://nixos.wiki/wiki/Greetd
      # tweaked for Hyprland
      # ...
      # launches into hyprland on boot
      # Super + L launches swaylock with exec-once in home/hyprland/hyprland.conf (lockscreen)
      # logout with `hyprctl dispatch exit` to logout, which starts tuigreet
      # ...
      greetd = {
        enable = true;
        settings = {
          initial_session = {
            command = "${pkgs.hyprland}/bin/Hyprland";
            user = "iancleary";
          };
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${pkgs.hyprland}/bin/Hyprland";
            user = "greeter";
          };
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [

        hyprpaper # wallpaper utility
        hyprpicker # color picker
        wl-clipboard # allows copying to clipboard (for hyprpicker)
        kitty # terminal emulator
        waybar # wayland bar
        # wofi # app launcher, replaced by centerpiece

        # waybar applets
        networkmanagerapplet # nm-applet --indicator &
        blueman # blueman-applet
        udiskie # removable media/disk mounting

        polkit_gnome # polkit agent for GNOME
        gnome.seahorse # keyring manager GUI
        gnome.nautilus # file manager

        playerctl # media player control
        brightnessctl # brightness control
        pwvucontrol # sound control

        blueberry # bluetooth manager GUI
        networkmanager # network manager, including nmtui, a network manager TUI

        swaylock # screen locker

        xdg-utils # allow xdg-open to work

        inter # font

        firefox
        spotify
        linssid
        angryipscanner
        # todoist-electron

        inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      ];
    };
  };
}
