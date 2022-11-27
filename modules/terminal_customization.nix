# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    colorls
    oh-my-zsh
    zsh
    zsh-history
    zsh-completions
    zsh-powerlevel10k
    zsh-syntax-highlighting
  ];

  environment.shells = with pkgs; [ zsh ];

  # Enable ZSH
  programs.zsh.enable = true;

  # Enable oh-my-zsh
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "gitfast" "yarn" "zsh-syntax-highlighting" "powerlevel10k" ];
  }; 
}
