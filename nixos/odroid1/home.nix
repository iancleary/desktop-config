{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  myHome = {
    gnome.enable = false;
    kde.enable = false;
    hyprland.enable = false;
    nextcloud-autosync = {
      enable = false;
    };
  };

  myTerminal = {
    cli.personalGitEnable = true;
    zsh.enable = true;
    neovim = {
      enable = true;
      enableLSP = true;
    };
  };

  programs.centerpiece.enable = false;
  # home.packages = with pkgs; [
  # ];
}
