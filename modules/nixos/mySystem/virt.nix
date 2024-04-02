{ config, lib, pkgs, ... }:

{
  options.mySystem = with lib; {
    vmHost = mkOption {
      type = types.bool;
      default = false;
    };
    dockerHost = mkOption {
      type = types.bool;
      default = false;
    };
    virtualboxGuest = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.mySystem.vmHost {
      users.users.${config.mySystem.user}.extraGroups = [ "libvirtd" ];
      virtualisation.libvirtd.enable = true;
      environment.systemPackages = lib.mkIf config.mySystem.gnome.enable [ pkgs.virt-manager ];
    })
    (lib.mkIf config.mySystem.dockerHost {
      users.users.${config.mySystem.user}.extraGroups = [ "docker" ];
      virtualisation.docker = {
        enable = true;
      };
      systemd.network.wait-online.ignoredInterfaces = [
        "docker0"
      ];
    })
    (lib.mkIf config.mySystem.virtualboxGuest {
      virtualisation.virtualbox.guest.enable = true;
      users.users.${config.mySystem.user}.extraGroups = [ "vboxsf" ];
      # boot.kernelPackages = pkgs.linuxPackages_latest;
      # boot.supportedFilesystems = [ "vboxsf" ];
      # boot.extraModulePackages = [ pkgs.virtualboxGuestAdditions ];
    })
  ];
}
