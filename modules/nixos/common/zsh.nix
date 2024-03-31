# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
 
  programs.zsh.enable = true;
  
  ########
  ## When using SSH, Windows Terminal, or VS Code with a shared directory
  ## You need the fonts installed on the host machine, not the nix target
  ##
  ## To install them on your local machine
  ## https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
  ########
  fonts = {
    # Install font (on the nix target, see above for WSL or virtual machine)
    # tl;dr you install fonts on the machine that is rendering the fonts  
    packages = with pkgs; [
      meslo-lgs-nf
    ];
    # https://github.com/nix-community/home-manager/issues/605#issuecomment-753667922
    fontconfig = {
      enable = true;
      # https://nixos.wiki/wiki/Fonts
      defaultFonts = {
        serif = [ "meslo-lgs-nf" ];
        sansSerif = [ "meslo-lgs-nf" ];
        monospace = [ "meslo-lgs-nf" ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      zsh
    ];
    # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.enableCompletion
    pathsToLink = [ "/share/zsh" ];

    # https://nixos.wiki/wiki/Command_Shell
    # Many programs look at /etc/shells to determine if a user is a "normal" user and not a "system" user.
    # Therefore it is recommended to add the user shells to this list.
    # To add a shell to /etc/shells use the following line in your config:
    shells = with pkgs; [ zsh ];
  };

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;
}
