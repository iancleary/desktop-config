# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ./modules/nixos-version/22.11.nix # IMPORTANT

      <home-manager/nixos>
      ./users/icleary/home-manager.nix
      ./users/icleary/authorized-keys.nix
      ./users/icleary/vboxsf.nix

      ./modules/common/docker.nix
      ./modules/common/localBinInPath.nix
      ./modules/common/packages.nix
      ./modules/common/zsh.nix
      ./modules/common/x11-keymap.nix

      ./modules/localization/en_US.nix

      ./modules/networking/hostname/vm-icleary-nixos.nix
      ./modules/networking/networkmanager/enabled.nix
      ./modules/networking/openssh/enabled.nix
      ./modules/networking/openssh/start-ssh-agent.nix
      ./modules/networking/wait-online.nix

      ./modules/timezone/America-Phoenix.nix

      ./modules/unfree/allowed.nix

      ./modules/virtualbox/guest-enabled.nix


    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

}
