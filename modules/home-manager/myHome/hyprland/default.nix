# home.nix
{ config, inputs, lib, ... }:
let
  cfg = config.myHome.hyprland;
in
{

  imports = [
    inputs.centerpiece.hmModules."x86_64-linux".default
  ];
  config = lib.mkIf cfg.enable {
    # hyprland configuration
    home.file = {
      #".config/hypr/hyprland.conf".source = ./hyprland.conf;
      #".config/hypr/hyprland.conf".target = ".config/hypr/hyprland.conf";

      # wallpaper configuration
      ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
      ".config/hypr/hyprpaper.conf".target = ".config/hypr/hyprpaper.conf";

      ".config/waybar/config".source = ./waybar.config;
      ".config/waybar/config".target = ".config/waybar/config";

      ".config/waybar/style.css".source = ./waybar.css;
      ".config/waybar/style.css".target = ".config/waybar/style.css";

      ".config/hypr/wallpaper-red.jpg".source = ./justinmaller-red-black-abstract.jpg;
      ".config/hypr/wallpaper-red.jpg".target = ".config/hypr/wallpaper-red.jpg";

      ".config/hypr/wallpaper-blue.jpg".source = ./justinmaller-blue-black-abstract.jpg;
      ".config/hypr/wallpaper-blue.jpg".target = ".config/hypr/wallpaper-blue.jpg";

      ".config/hypr/lock.png".source = ./linux_makes_journeys_to_mars_possible.png;
      ".config/hypr/lock.png".target = ".config/hypr/lock.png";

      ".config/hypr/wofi.css".source = ./wofi.css;
      ".config/hypr/wofi.css".target = ".config/hypr/wofi.css";
    };

    programs.centerpiece = {
      enable = true;
      config = {
        plugin = {
          applications = {
              enable = true;
          };
          brave_bookmarks = {
            enable = true;
          };
          brave_history = {
            enable = true;
          };
          brave_progressive_web_apps = {
            enable = true;
          };
          clock = {
              enable = true;
          };
          firefox_bookmarks = {
              enable = true;
          };
          firefox_history = {
                enable = true;
          };
          git_repositories = {
              enable = true;
              commands = [
                  ["alacritty" "--command" "nvim" "$GIT_DIRECTORY"]
                  ["alacritty" "--working-directory" "$GIT_DIRECTORY"]
              ];
          };
          gitmoji = {
              enable = false;
          };
          resource_monitor_battery = {
              enable = true;
          };
          resource_monitor_cpu = {
              enable = true;
          };
          resource_monitor_disks = {
              enable = true;
          };
          resource_monitor_memory = {
              enable = true;
          };
          system = {
              enable = true;
          };
          wifi = {
              enable = true;
          };
        };
      };
    # enables a systemd service to index git-repositories
    services.index-git-repositories = {
         enable = true;
         interval = "5min";
      };
    };
  };
}
