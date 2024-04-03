{
  home = rec {
    username = "root";
    homeDirectory = "/${username}";
    stateVersion = "23.11";
  };

  myHome = {
    nonNixos.enable = true;
    gnome.enable = false;
    cli.personalGitEnable = true;
    tmux.enable = true;
    zsh.enable = true;
    neovim = {
      enable = true;
      enableLSP = true;
    };
  };
}