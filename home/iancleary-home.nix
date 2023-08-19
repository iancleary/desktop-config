{ inputs, config, pkgs, lib, home-manager, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.users.iancleary = {
    home.stateVersion = "23.05";

    imports = [
      ./direnv.nix
      ./gnome.nix
      ./zsh.nix
    ];
  };
}
