{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.kde;
in
{
  options.mySystem.kde = {
    enable = lib.mkEnableOption "kde";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        firefox
        wl-clipboard
        spotify
        linssid
        angryipscanner
        todoist-electron
        xdg-desktop-portal-kde
      ];
      plasma6.excludePackages = with pkgs.plasma6; [

      ];
    };

    services = {
      xserver = {
        enable = true;
        # Configure keymap in X11
        xkb = {
          layout = "us";
          variant = "";
        };
        # Excluding some GNOME applications from the default install
        excludePackages = with pkgs; [
          xterm
        ];
      };
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
#       udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
      };

      # Install Flatpak
      flatpak.enable = true;
    };

    programs = {
      zsh.vteIntegration = true;
      kdeconnect = {
        enable = true;
      };
    };

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    sound.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-kde
      ];
    };

    systemd = {
      # https://discourse.nixos.org/t/how-to-disable-networkmanager-wait-online-service-in-the-configuration-file/19963/2
      services.NetworkManager-wait-online.enable = false;

      network.wait-online = {
        ignoredInterfaces = [
          "lo"
        ];
        # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1273814285
        anyInterface = true;
      };
    };
  };
}
