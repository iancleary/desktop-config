{
  services.tailscale = {
    extraUpFlags = [
      "--ssh"
    ];
    authKeyFile = "/etc/nixos/secrets/tailscale_key";
  };
}
