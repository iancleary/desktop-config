{ ... }: {
  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Direnv templates and remote sources
  home = {
    file."dvd".source = ./dvd;
    file."dvd".target = ".local/bin/dvd";
    file."dvd".executable = true;
    file."dvt".source = ./dvt;
    file."dvt".target = ".local/bin/dvt";
    file."dvt".executable = true;
  };
}
