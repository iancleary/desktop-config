{ config, lib, pkgs, ... }:

let
    cfg = config.mySystem.tailscale;
in
{
  options.mySystem.tailscale = {
    enable = lib.mkEnableOption "tailscale";
  };

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;

    environment.systemPackages = with pkgs; [
      tailscale
    ];

    systemd.network.wait-online.ignoredInterfaces = [
      "tailscale0"
    ];
  };
}
