{ config, inputs, lib, ... }:

let
  cfg = config.myHome;
in
{
  options.myHome.gnome = with lib; {
    enable = mkEnableOption "gnome";
  };

  options.myHome.kde = with lib; {
    enable = mkEnableOption "kde";
  };

  imports = [
    ./colors.nix
    ./gnome
    ./nextcloud-autosync
    ./non-nixos.nix
    inputs.terminal-config.homeManagerModules.default
  ];
}
