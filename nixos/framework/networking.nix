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
  systemd.network = {
    enable = true;
    wait-online.extraArgs = [ "--interface" "eth0" ];
  };
  services.resolved = {
    enable = true;
  #  extraConfig = ''
  #       DNS = 10.69.1.243
  #     '';
  };
}
