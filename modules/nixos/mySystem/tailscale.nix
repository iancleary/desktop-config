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
    services.tailscale = {
      enable = true;
      package = lib.mkMerge [
        (lib.mkIf cfg.unstable pkgs.unstable.tailscale)
        (lib.mkIf (!cfg.unstable) pkgs.tailscale)
      ];
    };

    systemd.network.wait-online.ignoredInterfaces = [
      "tailscale0"
    ];
  };
}
