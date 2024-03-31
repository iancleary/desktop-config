# home.nix
{ config, pkgs, ... }: {
  # Login picture/avatar

  # hyprland configuration
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/hyprland.conf".target = ".config/hypr/hyprland.conf";

  # wallpaper configuration
  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/hypr/hyprpaper.conf".target = ".config/hypr/hyprpaper.conf";


  home.file.".config/hypr/wallpaper-red.jpg".source = ./justinmaller-red-black-abstract.jpg;
  home.file.".config/hypr/wallpaper-red.jpg".target = ".config/hypr/wallpaper-red.jpg";

  home.file.".config/hypr/wallpaper-blue.jpg".source = ./justinmaller-blue-black-abstract.jpg;
  home.file.".config/hypr/wallpaper-blue.jpg".target = ".config/hypr/wallpaper-blue.jpg";

  home.file.".config/hypr/lock.png".source = ./linux_makes_journeys_to_mars_possible.png;
  home.file.".config/hypr/lock.png".target = ".config/hypr/lock.png";

  home.file.".config/hypr/wofi.css".source = ./wofi.css;
  home.file.".config/hypr/wofi.css".target = ".config/hypr/wofi.css";
}
