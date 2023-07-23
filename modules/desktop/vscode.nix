# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  # Passing config into the variable definition is necessary to allow
  # the use of config.allowUnfree in the unstable channel.
  # https://nixos.wiki/index.php?title=FAQ&oldid=3528#How_can_I_install_a_package_from_unstable_while_remaining_on_the_stable_channel.3F
  # https://discourse.nixos.org/t/allow-unfree-from-unstable/23218/2
  unstable = import <nixos-unstable> { config.allowUnfree = true;};
in {
  environment.systemPackages = [ 
    unstable.vscode-fhs # vscode with FHS (File Hierarchy System) layout
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
