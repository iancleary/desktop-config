# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  # Whether to start the OpenSSH agent when you log in.  The OpenSSH agent
  # remembers private keys for you so that you don't have to type in
  # passphrases every time you make an SSH connection.  Use
  # {command}`ssh-add` to add a key to the agent.
  programs.ssh.startAgent = true;
}
