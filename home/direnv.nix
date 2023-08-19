{ ... }: {
  # https://github.com/nix-community/nix-direnv#via-home-manager
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Direnv templates and remote sources
  home.file."dvd".source = ./dotfiles/dvd;
  home.file."dvd".target = ".local/bin/dvd";
  home.file."dvd".executable = true;
  home.file."dvt".source = ./dotfiles/dvt;
  home.file."dvt".target = ".local/bin/dvt";
  home.file."dvt".executable = true;
}
