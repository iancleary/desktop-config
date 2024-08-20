{ config, pkgs, ... }:

{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 1883 8123 9541 21065 ];
      allowedUDPPorts = [ 5353 ];
      # 1883 -> MQTT,

      # https://www.home-assistant.io/integrations/homekit/#firewall
      # 5353 -> mDNS,

      # 8123 Home Assistant Web UI,

      # Not used in my setup, but might be useful for others:
      # 8883 -> MQTT over SSL,
      # 9001 -> MQTT Websockets,

      # 9541 -> TasmoAdmin,

      # https://www.home-assistant.io/integrations/homekit/#firewall
      # 21063 -> Homekit Bridge (or whatever port you configure the brige to use)
      # 21064 -> Homekit Bridge (or whatever port you configure the brige to use)
      # 21065 -> Homekit Bridge (https://www.home-assistant.io/integrations/homekit/)
      # 51827 -> HomeKit (old, N/A anymore)
    };
  };
}
