# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
  ];

  programs.zsh.enable = true;

  # https://github.com/nix-community/home-manager/issues/605#issuecomment-753667922
  fonts.fontconfig.enable = true;

  # fonts.fontDir.enable = true;

  ########
  ## When using SSH, Windows Terminal, or VS Code with a shared directory
  ## You need the fonts installed on the host machine, not the Virtual Machine
  ## Below installs them on the Virtual Machine.
  ##
  ## To install them on your local machine
  ## https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k
  ########

  # # https://nixos.wiki/wiki/Fonts
  fonts.fonts = with pkgs; [
    meslo-lgs-nf
  ];
  fonts.fontconfig.defaultFonts.serif = ["meslo-lgs-nf"];
  fonts.fontconfig.defaultFonts.sansSerif = ["meslo-lgs-nf"];
  fonts.fontconfig.defaultFonts.monospace = ["meslo-lgs-nf"];

  # https://nixos.wiki/wiki/Command_Shell
  # Many programs look at /etc/shells to determine if a user is a "normal" user and not a "system" user.
  # Therefore it is recommended to add the user shells to this list.
  # To add a shell to /etc/shells use the following line in your config:
  environment.shells = with pkgs; [ zsh ];

  # https://nix-community.github.io/home-manager/options.html#opt-programs.zsh.enableCompletion
  environment.pathsToLink = [ "/share/zsh" ];

  # https://nixos.wiki/wiki/Command_Shell
  users.defaultUserShell = pkgs.zsh;
}
