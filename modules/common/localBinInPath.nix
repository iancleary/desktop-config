
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    # Add ~/.local/bin/ to $PATH
    # https://nixos.org/manual/nixos/stable/options.html#opt-environment.localBinInPath
    environment.localBinInPath = true;
}
