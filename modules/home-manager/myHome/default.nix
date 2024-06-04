{ inputs, ... }:
{
  imports = [
    ./colors.nix
    #     ./gnome
    ./nextcloud-autosync
    ./non-nixos.nix
    inputs.terminal-config.homeManagerModules.default
  ];
}
