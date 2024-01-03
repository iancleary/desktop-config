# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
let
  # Mixing unstable and stable channels
  # https://nixos.wiki/index.php?title=FAQ&oldid=3528#How_can_I_install_a_package_from_unstable_while_remaining_on_the_stable_channel.3F
  pkgs-unstable = (import inputs.nixpkgs-unstable) {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = [
    # https://github.com/NixOS/nixpkgs/issues/246509
    # env -u WAYLAND_DISPLAY code .
    # Setting "window.titleBarStyle" = "custom";works for me as a workaround.
    # ^ Ran `env -u WAYLAND_DISPLAY code .` once, then updated the settings via Preferences,
    #   then no longer need `env -u ...`
    pkgs-unstable.vscode-fhs # vscode with FHS (File Hierarchy System) layout
    # pkgs.vscode-fhs # vscode with FHS (File Hierarchy System) layout
  ];
}
