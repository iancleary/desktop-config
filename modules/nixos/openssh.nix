{ config, pkgs, ... }:
{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings = {
      # https://nixos.org/manual/nixos/stable/release-notes.html#sec-release-23.05-notable-changes
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # Whether to start the OpenSSH agent when you log in.  The OpenSSH agent
  # remembers private keys for you so that you don't have to type in
  # passphrases every time you make an SSH connection.  Use
  # {command}`ssh-add` to add a key to the agent.
  programs.ssh.startAgent = true;
}
