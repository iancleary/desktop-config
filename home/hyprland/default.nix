# home.nix
{ config, pkgs, ... }: {
  # Login picture/avatar

  # hyprland configuration
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprland.conf".target = ".config/hypr/hyprland.conf";

  # wallpaper configuration
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/hypr/hyprpaper.conf".target = ".config/hypr/hyprpaper.conf";

  home.file."Pictures/backgrounds/justinmaller-red-black-abstract.jpg".source = ./justinmaller-red-black-abstract.jpg;
  home.file."Pictures/backgrounds/justinmaller-red-black-abstract.jpg".target = Pictures/backgrounds/justinmaller-red-black-abstract.jpg;

  home.file."Pictures/backgrounds/justinmaller-blue-black-abstract.jpg".source = ./justinmaller-blue-black-abstract.jpg;
  home.file."Pictures/backgrounds/justinmaller-blue-black-abstract.jpg".target = Pictures/backgrounds/justinmaller-blue-black-abstract.jpg;
}
