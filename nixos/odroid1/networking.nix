{ config, lib, ... }:

{
  #   imports = [ ./vpn.nix ];

  networking = {
    useNetworkd = true;
    enableIPv6 = false;
    # "Predictable" interface names are not that predictable lol
    usePredictableInterfaceNames = false;
    # NetworkManager is implicitly enabled by gnome (should be, testing out true to see if wifi works)
    networkmanager.enable = true;
    # DHCPCD is still the default on NixOS
    dhcpcd.enable = false;
  };
  systemd.services = {
    NetworkManager-wait-online.enable = lib.mkForce false;
    systemd-networkd-wait-online.enable = lib.mkForce false;
  };
  systemd.network = {
    enable = true;
  };
  services.resolved = {
    enable = true;
  };
}
