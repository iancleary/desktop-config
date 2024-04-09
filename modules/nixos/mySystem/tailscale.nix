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

    environment.systemPackages = with pkgs; lib.mkMerge [
      (lib.mkIf cfg.unstable unstable.tailscale)
      (lib.mkIf (!cfg.unstable) tailscale)
    ];

    systemd.network.wait-online.ignoredInterfaces = [
      "tailscale0"
    ];
  };
}
