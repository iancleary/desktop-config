{ config, pkgs, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

  
  systemd = {
    # https://discourse.nixos.org/t/how-to-disable-networkmanager-wait-online-service-in-the-configuration-file/19963/2
    services.NetworkManager-wait-online.enable = false;

    network.wait-online = {
      ignoredInterfaces = [
        "lo"
      ];
      # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1273814285
      anyInterface = true;
    };
  };
}
