  # Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings = {
      # https://nixos.org/manual/nixos/stable/release-notes.html#sec-release-23.05-notable-changes
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
}
