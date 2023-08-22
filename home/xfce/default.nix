{ pkgs, ... }: {

  home.packages = with pkgs; [
    zuki-themes
    elementary-xfce-icon-theme
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      code = "code --enable-features=Vulkan";
    };
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "elementary-xfce-dark";
      package = pkgs.elementary-xfce-icon-theme;
    };
    theme = {
      name = "Zukitre-dark";
      package = pkgs.zuki-themes;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
}
