# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:
let
  # Mixing unstable and stable channels
  # https://nixos.wiki/index.php?title=FAQ&oldid=3528#How_can_I_install_a_package_from_unstable_while_remaining_on_the_stable_channel.3F
  pkgs-unstable = (import inputs.nixpkgs-unstable) {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # Optional, hint electron apps to use wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Install Flatpak
  services.flatpak.enable = true;

  # Gnome Keyring
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  # swaylock
  # https://discourse.nixos.org/t/swaylock-wont-unlock/27275
  security.pam.services.swaylock = { };
  security.pam.services.swaylock.fprintAuth = false;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland # display portal for hyprland, required
    hyprpaper # wallpaper utility
    hyprpicker # color picker
    wl-clipboard # allows copying to clipboard (for hyprpicker)
    kitty # terminal emulator
    waybar # wayland bar
    wofi # app launcher

    polkit_gnome # polkit agent for GNOME
    gnome.seahorse # keyring manager GUI
    gnome.nautilus # file manager

    playerctl # media player control
    brightnessctl # brightness control

    swaylock # screen locker

    xdg-utils # allow xdg-open to work

    greetd.greetd # login manager daemon
    greetd.gtkgreet # GTK based greeter for greetd

    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    # pkgs-unstable.lemurs # TUI Login manager (crashes on NixOS)
  ];

  # https://nixos.wiki/wiki/Greetd
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${programs.Hyprland.package} --config /home/iancleary/.config/hypr/hyprland.conf";
        user = "iancleary";
      };
      default_session = initial_session;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  #  systemd.services.hyprland = {
  #   enable = true;
  #   description = "Hyprland";
  #   # script = "/run/current-system/sw/bin/ulauncher --hide-window";
  #   script = "agetty -o '-p -f -- \u' --noclear --autologin iancleary %I $TERM";
  #   serviceConfig = {
  #     StandardInput = "tty";
  #     TTYPath = "/dev/tty2";
  #     TTYReset = "yes";
  #     TTYVHangup = "yes";
  #     Type = "idle";
  #   };
  #   aliases = [ "display-manager.service" ];
  #   documentation = [ "https://github.com/coastalwhite/lemurs" ];
  #   after = [ "sysinit.target" ];
  # };

  # Service to start
  # copied from https://discourse.nixos.org/t/ulauncher-and-the-debugging-journey/13141/5?u=iancleary
  # modified to use pkg-unstable instead of pkgs
  # names of wantedBy targets and after services are different for user services
  # launches with CTRL+SPACE
  # systemd.services.lemurs = {
  #   enable = true;
  #   description = "Lemurs";
  #   # script = "/run/current-system/sw/bin/ulauncher --hide-window";
  #   script = "/run/current-system/sw/bin/lemurs";
  #   serviceConfig = {
  #     StandardInput = "tty";
  #     TTYPath = "/dev/tty2";
  #     TTYReset = "yes";
  #     TTYVHangup = "yes";
  #     Type = "idle";
  #   };
  #   aliases = [ "display-manager.service" ];
  #   documentation = [ "https://github.com/coastalwhite/lemurs" ];
  #   after = [ "getty.target" ];
  # };



  # systemd.user.services.hyprland = {
  #   enable = true;
  #   description = "Start Hyprland";
  #   # script = "/run/current-system/sw/bin/ulauncher --hide-window";
  #   script = "/run/current-system/sw/bin/Hyprland --config /home/iancleary/.config/hypr/hyprland.conf";

  #   documentation = [ "https://github.com/hyperwm/Hyprland" ];
  #   wantedBy = [ "default.target" ];
  #   after = [ "default.target" ];
  # };
}
