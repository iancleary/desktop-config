# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include home configuration (per hostname)
      # <home-manager/nixos>
      ./home_manager.nix
      # These files will be symlinks to this relative path
      ./modules/allow_unfree.nix
      
      ./modules/bootloader.nix
      
      ./modules/cli_packages.nix
      ./modules/desktop_packages.nix
      
      ./modules/gnome_and_x11.nix
      
      ./modules/install_docker.nix
      ./modules/install_flatpak.nix
      ./modules/install_tailscale.nix
      
      ./modules/networking.nix

      ./modules/services_printing.nix
      ./modules/services_sound.nix
      
      ./modules/sw_development.nix
      
      ./modules/terminal_customization.nix
      
      ./modules/time_and_localization.nix
      
      ./modules/user_accounts.nix

      ./editors/vscode.nix
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
