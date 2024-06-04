{ inputs, outputs, config, lib, pkgs, ... }:

let
  cfg = config.mySystem;
in
{
  options.mySystem = {
    user = lib.mkOption {
      default = "iancleary";
      type = lib.types.str;
    };
    home-manager = {
      enable = lib.mkEnableOption "home-manager";
      home = lib.mkOption {
        default = ../../../home-manager;
        type = lib.types.path;
      };
    };
  };

  config = {
    home-manager = lib.mkIf cfg.home-manager.enable {
      useGlobalPkgs = lib.mkDefault true;
      useUserPackages = lib.mkDefault true;
      extraSpecialArgs = { inherit inputs; };
      sharedModules = builtins.attrValues outputs.homeManagerModules;
      users."${cfg.user}" = import cfg.home-manager.home;
      backupFileExtension = "backup";
    };
    users = {
      defaultUserShell = pkgs.zsh;
      users.${cfg.user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "keys" ];
      };
    };
    programs = {
      neovim = {
        enable = true;
        defaultEditor = true;
      };
      zsh = {
        enable = true; # Workaround for https://github.com/nix-community/home-manager/issues/2751
        enableCompletion = false;
      };
    };

    # Whether to start the OpenSSH agent when you log in.  The OpenSSH agent
    # remembers private keys for you so that you don't have to type in
    # passphrases every time you make an SSH connection.  Use
    # {command}`ssh-add` to add a key to the agent.
    programs.ssh.startAgent = lib.mkDefault true;


    # Add ~/.local/bin/ to $PATH
    # https://nixos.org/manual/nixos/stable/options.html#opt-environment.localBinInPath
    environment.localBinInPath = true;
  };
}
