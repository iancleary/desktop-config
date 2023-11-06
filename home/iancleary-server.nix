#
Edit this configuration file to define what should be installed on
  # your system.  Help is available in the configuration.nix(5) man page
  # and in the NixOS manual (accessible by running ‘nixos-help’).

  { config, inputs, pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    home-manager.users.iancleary = {
      home.stateVersion = "23.05";
      imports = [
        ./common.nix
      ];
    };
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.iancleary = {
      isNormalUser = true;
      description = "iancleary";
      extraGroups = [ "networkmanager" "wheel" "docker" "vboxsf" ];
    };
  }
