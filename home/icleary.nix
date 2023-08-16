{ ... }: {
  users.users.icleary =
    {
      home = "/home/icleary";
      isNormalUser = true;
      description = "icleary";
      extraGroups = [
        "icleary"
        "wheel"
        "docker"
        "vboxsf"
      ];
    };
}
