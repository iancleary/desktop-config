{ config, pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
    };
  };

  # Add user to docker group
  users.users.iancleary.extraGroups = [ "docker" ];

  # docker-compose
  environment.systemPackages = [
    pkgs.docker-compose
  ];
}
