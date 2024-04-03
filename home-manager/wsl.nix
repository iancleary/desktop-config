{
  home = rec {
    username = "root";
    homeDirectory = "/${username}";
    stateVersion = "23.11";
  };

  myHome = {
    wsl.enable = true;
    cli.personalGitEnable = true;
    tmux.enable = true;
    zsh.enable = true;
    neovim = {
      enable = true;
      enableLSP = true;
    };
    # Not a graphical installation
    nonNixos.enable = false; # Ubuntu Desktop, for example
    gnome.enable = false;
  };

  # Not a graphical installation
  xdg.enable = false;
}
