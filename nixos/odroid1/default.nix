# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.hardkernel-odroid-h3
    ./hardware-configuration.nix
    ./networking.nix
    ../odroid_common/docker.nix
    ../odroid_common/homeassistant.nix
    ../odroid_common/unifi.nix
    ./nextcloud.nix
    ./tailscale.nix
  ];

  mySystem = {
    gnome.enable = false;
    kde.enable = false;
    hyprland.enable = false;
    gaming.enable = false;
    tailscale = {
      enable = true;
      unstable = true;
    };
    vmHost = false;
    dockerHost = true;
    home-manager = {
      enable = true;
      home = ./home.nix;
    };
    # nix.substituters = [ "nasgul" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Latest kernel for ZFS
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  networking.hostName = "odroid1"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  networking.hostId = "8425e349";

  # Set your time zone.
  # time.timeZone = "America/Phoenix";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # don't allow mutation of users outside of config
  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.iancleary = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    # initialPassword = "password";
    initialHashedPassword = "$y$j9T$Ov2T/rXjvlEr48/5akCcx0$xOvKr97FRq9TLPLVKhEC7rtF7sfvOwpeL2/DC4a2vO1";
  };

  # packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
      # for ansible configuration
      # it's located here so this configuration can be copy
      # and pasted into a new system, without ansible
      (
        python310.withPackages(
            ps: with ps; [
                # for community.docker.docker_image
                # and community.docker.docker_compose_v2
                requests
                ]
        )
      )
  ];


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?



}
