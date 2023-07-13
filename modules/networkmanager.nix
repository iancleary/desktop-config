
{ config, pkgs, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

  # https://discourse.nixos.org/t/how-to-disable-networkmanager-wait-online-service-in-the-configuration-file/19963/2
  systemd.services.NetworkManager-wait-online.enable = false;

  # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1273814285
  systemd.network.wait-online.anyInterface = true;

  systemd.network.wait-online.ignoredInterfaces = [
    "lo"
  ];
}
