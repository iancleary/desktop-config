# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Host Specific
      ./modules/virtualbox/guest-enabled.nix

      # User Specific
      <home-manager/nixos>
      ./users/icleary/home-manager.nix
      ./users/icleary/authorized-keys.nix
      ./users/icleary/vboxsf.nix

      # Common
      ./modules/common/docker.nix
      ./modules/common/localBinInPath.nix
      ./modules/common/packages.nix
      ./modules/common/zsh.nix
      ./modules/common/x11-keymap.nix

      ./modules/networkmanager.nix
      ./modules/openssh.nix

      ./modules/unfree-allowed.nix
    ];

  # Define your hostname.
  networking.hostName = "vm-icleary-nixos";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
