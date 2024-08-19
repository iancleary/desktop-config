{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      # https://github.com/linuxserver/docker-unifi-network-application?tab=readme-ov-file#parameters
      allowedTCPPorts = [
        8080 # Port for UAP to inform controller.
        8880 # Port for HTTP portal redirect, if guest portal is enabled.
        8843 # Port for HTTPS portal redirect, ditto.
        6789 # Port for UniFi mobile speed test.
      ];
      allowedUDPPorts = [
        3478 # UDP port used for STUN.
        10001 # UDP port used for device discovery.
      ];
    };
  };
}


# { config, pkgs, lib, ... }:

# {

#   # For all packages
#   # This method works for NixOS system-level configuration:
#   nixpkgs.config.allowUnfree = true;

#   # Per-package (Ideal)
#   # This method works for NixOS system level configuration and Home-Manager standalone
#   # nixpkgs.config.allowUnfreePredicate = pkg:
#   #   builtins.elem (lib.getName pkg) [
#   #     # Add additional package names here
#   #     # "unifi5"
#   #     "unifiLTS"
#   #   ];

#   services.unifi = {
#     enable = true;
#     # https://github.com/NixOS/nixpkgs/blob/e0da498ad77ac8909a980f07eff060862417ccf7/pkgs/servers/unifi/default.nix#L48-L50
#     # unifiPackage = pkgs.unifi5; # LTS version
#     # mongodbPackage = pkgs.mongodb-4_4;

#     # https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/nixos/modules/services/networking/unifi.nix#L100-L112
#     openFirewall = true;
#     # The following ports are required for UniFi to function properly.
#     # https://help.ubnt.com/hc/en-us/articles/218506997
#     # allowedTCPPorts = [
#     #   8080  # Port for UAP to inform controller.
#     #   8880  # Port for HTTP portal redirect, if guest portal is enabled.
#     #   8843  # Port for HTTPS portal redirect, ditto.
#     #   6789  # Port for UniFi mobile speed test.
#     # ];
#     # allowedUDPPorts = [
#     #   3478  # UDP port used for STUN.
#     #   10001 # UDP port used for device discovery.
#     # ];

#   };
# }
