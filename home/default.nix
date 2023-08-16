# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ username, ... }:

{
  include = [
    ./gnome.nix
  ]
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.groups = {
  "${username}" = {};
  docker = { };
};
users.users."${username}" = {
home = "/home/${username}";
isNormalUser = true;
description = username;
extraGroups = [
username
"wheel"
"docker"
"vboxsf"
];
}
}
