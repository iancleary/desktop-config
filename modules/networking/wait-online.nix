# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  # https://discourse.nixos.org/t/how-to-disable-networkmanager-wait-online-service-in-the-configuration-file/19963/2
  systemd.services.NetworkManager-wait-online.enable = false;
  # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1273814285
  systemd.network.wait-online.anyInterface = true;
  systemd.network.wait-online.ignoredInterfaces = [
    "tailscale0"
    "lo"
    "docker0"
  ];

}
