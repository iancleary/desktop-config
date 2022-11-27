{ config, pkgs, ... }:

with builtins;
with lib;

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.iancleary = {
    /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
    programs.git = {
        enable = true;
        userName  = "iancleary";
        userEmail = "hello@iancleary.me";
    };
    home.file = {

      ".ssh/config" = {
      text = ''
      Host pihole
        HostName rpi3bv2p0.tail2500d.ts.net
        User iancleary
        IdentityFile ~/.ssh/github_id_ed25519

      Host primary
        HostName ubuntu-primary.tail2500d.ts.net
        User iancleary
        IdentityFile ~/.ssh/github_id_ed25519

      Host gitea
        HostName tower.tail2500d.ts.net
        User iancleary
        Port 2022
        IdentityFile ~/.ssh/github_id_ed25519

      Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/github_id_ed25519


      Host *
        IgnoreUnknown UseKeychain
        UseKeychain yes
        AddKeysToAgent yes
        IdentityFile ~/.ssh/github_id_ed25519
      ''; 
      };

    };
  };
}
