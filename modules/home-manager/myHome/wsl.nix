{ inputs, outputs, config, lib, pkgs, ... }:

let
  cfg = config.myHome.wsl;
in
{
  options.myHome.wsl = with lib; {
    enable = mkEnableOption "wsl";
  };
  config = lib.mkIf cfg.enable {
    home.sessionPath = [ "$HOME/.local/bin" ];
    home.packages = [
      pkgs.hostname
      config.nix.package # This must be here, enable option below does not ensure that nix is available in path
    ];

    nixpkgs.overlays = builtins.attrValues outputs.overlays;
    nixpkgs.config.allowUnfree = true;
    nix = {
      enable = true;
      package = pkgs.nix;
      extraOptions = ''
        experimental-features = nix-command flakes
        !include ./extra.conf
      '';
      registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
      settings.nix-path = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    };
    programs.home-manager.enable = true;
  };
}
