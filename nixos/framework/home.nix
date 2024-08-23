{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  myHome = {
    gnome.enable = false;
    kde.enable = false;
    hyprland.enable = true;
    nextcloud-autosync = {
      enable = true;
      folder = "${config.home.homeDirectory}/Nextcloud/";
      server = "http://nextcloud.iancleary.me";
    };
  };

  myTerminal = {
    cli.personalGitEnable = true;
    tmux.enable = true;
    zsh.enable = true;
    neovim = {
      enable = true;
      enableLSP = true;
    };
  };

  home.packages = with pkgs; [
    alacritty

    # wezterm
    # https://github.com/wez/wezterm/discussions/3736#discussioncomment-9879261
    # Wezterm doesn't work on AMD framework as of 2024-08-22
    # you can check if this has changed since the above ^ date

    brave
    jellyfin-media-player
    protonup
    signal-desktop

    # super-slicer-latest # 3D Printer software
  ];
}
