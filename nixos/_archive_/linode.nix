# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "us-west-nixos-primary"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };


  users.users.iancleary = {
    isNormalUser = true;
    home = "/home/iancleary";
    description = "Ian Cleary";
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7RewHTrKsekCvRoPUZc0heu8MwSpdHsLqG9LYMdlkV github@iancleary.me"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmLe3vZflB95jEz3CJlqxKJLN6kPan8nk9CAdHNzLse github@iancleary.me"
    ];
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  environment.systemPackages = with pkgs; [
    # Linode Monitoring
    inetutils
    mtr
    sysstat

    # Use Cases
    git
    tailscale
    podman-compose
  ];

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
  virtualisation.oci-containers.backend = "podman";

  # List services that you want to enable:

  services.tailscale.enable = true;

  services.longview = {
    enable = true;
    apiKeyFile = "/var/lib/longview/apiKeyFile";
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no"; # Change after creating user

  networking.usePredictableInterfaceNames = false;
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  services.nginx.enable = true;
  services.nginx.virtualHosts."iancleary.dev" = {
    addSSL = true;
    enableACME = true;
    #root = "/var/www/iancleary.dev";
    locations."/" = {
      proxyPass = "http://127.0.0.1:8000";
    };
    basicAuth = { iancleary = (builtins.readFile ./secrets/nginx); };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "linode@iancleary.me";
  };


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
