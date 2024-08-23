{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.appimages;
in
{
  options.mySystem.appimages = {
    enable = lib.mkEnableOption "appimages";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        unstable.gearlever
      ];
    };
  };
}
