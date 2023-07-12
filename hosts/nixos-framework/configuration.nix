# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # ./modules/nixos-version/22.11.nix # IMPORTANT
      ./modules/nixos-version/23.05.nix # IMPORTANT

      <home-manager/nixos>
      ./users/iancleary/bare-metal.nix
      ./users/iancleary/home-manager.nix
      #./users/iancleary/authorized-keys.nix

      ./modules/bare-metal/sound.nix
      ./modules/bare-metal/printing.nix

      ./modules/common/docker.nix
      ./modules/common/localBinInPath.nix
      ./modules/common/packages.nix
      ./modules/common/zsh.nix
      ./modules/common/x11-keymap.nix

      ./modules/desktop/flatpak.nix
      ./modules/desktop/gnome-x11.nix
      ./modules/desktop/packages.nix

      ./modules/localization/en_US.nix

      ./modules/networking/hostname/nixos-framework.nix
      ./modules/networking/networkmanager/enabled.nix
      ./modules/networking/openssh/enabled.nix
      ./modules/networking/openssh/start-ssh-agent.nix
      ./modules/networking/wait-online.nix

      ./modules/timezone/America-Phoenix.nix

      ./modules/unfree/allowed.nix

      ./modules/vpn/tailscale.nix
    ];

  # Bootloader.
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/sda";
  #boot.loader.grub.useOSProber = true;

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
       efiSupport = true;
       #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
       device = "nodev";
    };
  };


}
