{
  home.stateVersion = "23.11";

  myHome = {
    gnome.enable = true;
  };

  myTerminal = {
    zsh.enable = true;
    neovim = {
      enable = true;
      enableLSP = true;
    };
    tmux.enable = true;
  };
}
