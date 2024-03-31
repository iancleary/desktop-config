{ ... }: {
  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Direnv templates and remote sources
  home = {
    file = {
      "dvd" = {
        source = ./dvd;
        target = ".local/bin/dvd";
        executable = true;
      };
      "dvt" = {
        source = ./dvt;
        target = ".local/bin/dvt";
        executable = true;
      };
    };
  };
}
