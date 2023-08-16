{ ... }: {
  users.users.iancleary =
    {
      home = "/home/iancleary";
      isNormalUser = true;
      description = "iancleary";
      extraGroups = [
        "iancleary"
        "wheel"
        "docker"
        "vboxsf"
      ];
    };
}
