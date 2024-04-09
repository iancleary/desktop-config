{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.tailscale;
in
{
  options.mySystem.tailscale = {
    enable = lib.mkEnableOption "tailscale";
    unstable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;

    environment.systemPackages = with pkgs; mkMerge [
      (mkIf cfg.unstable unstable.tailscale-unstable)
      (mkIf (!cfg.unstable) tailscale)
    ];

    systemd.network.wait-online.ignoredInterfaces = [
      "tailscale0"
    ];
  };
}
