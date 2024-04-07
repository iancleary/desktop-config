{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.nextcloud-autosync;
in
{
  options.myHome.nextcloud-autosync = with lib; {
    enable = mkEnableOption "nextcloud-autosync";
    folder = mkOption {
      type = types.path;
      default = "${config.home.homeDirectory}/Nextcloud/";
    };
    server = mkOption {
      type = types.str;
      default = "http://nextcloud.iancleary.me";
    };
    initialSyncDelay = mkOption {
      type = types.str;
      default = "5min";
    };
    rerunSyncDelay = mkOption {
      type = types.str;
      default = "60min";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nextcloud-client
    ];

    systemd.user = {
      services.nextcloud-autosync = {
        Unit = {
          Description = "Auto sync Nextcloud";
          After = "network-online.target";
        };
        Service = {
          Type = "simple";
          ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${cfg.folder}";
          ExecStart = "${pkgs.nextcloud-client}/bin/nextcloudcmd -h -n ${cfg.folder} ${cfg.server}";
          TimeoutStopSec = "180";
          KillMode = "process";
          KillSignal = "SIGINT";
        };
        Install.WantedBy = [ "multi-user.target" ];
      };
      timers.nextcloud-autosync = {
        Unit.Description = "Automatic sync files with Nextcloud when booted up after 5 minutes then rerun every 60 minutes";
        Timer.OnBootSec = "${cfg.initialSyncDelay}";
        Timer.OnUnitActiveSec = "${cfg.rerunSyncDelay}";
        Install.WantedBy = [ "multi-user.target" "timers.target" ];
      };
      startServices = true;
    };
  };
}
