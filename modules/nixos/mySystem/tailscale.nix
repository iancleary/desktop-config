{ config, pkgs, ... }:

{
  # Install tailscale
  services.tailscale.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  systemd.network.wait-online.ignoredInterfaces = [
    "tailscale0"
  ];
}
