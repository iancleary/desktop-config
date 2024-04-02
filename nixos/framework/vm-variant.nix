{ config, lib, ... }:

{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
    };
    users.users.${config.mySystem.user}.hashedPassword = "$y$j9T$Ov2T/rXjvlEr48/5akCcx0$xOvKr97FRq9TLPLVKhEC7rtF7sfvOwpeL2/DC4a2vO1";
    services = {
      xserver.displayManager = {
        gdm.autoSuspend = false;
        autoLogin = {
          enable = true;
          inherit (config.mySystem) user;
        };
      };
      nix-serve.enable = lib.mkForce false;
      resolved.extraConfig = lib.mkForce "";
    };
    networking.wg-quick.interfaces = lib.mkForce { };
    virtualisation.docker.storageDriver = lib.mkForce "overlay2";
  };
}
