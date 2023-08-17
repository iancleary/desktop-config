# nixos-config

Welcome to my nixos-config!

## Setup Channels and Home Manager

Channels for the current nixos release, nixpkgs unstable, and home-manager are all handled by the [flake.nix](flake.nix) file.

There is a good walkthrough here: [https://nixos-and-flakes.thiscute.world/](https://nixos-and-flakes.thiscute.world/).

### Flatpak

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

## Upgrading Versions

<https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module>
<https://nixos.org/manual/nixos/stable/index.html#sec-upgrading>

* Update the [flake.nix](flake.nix) file to use the new release
* Check the release notes for changes to modules
* Run `just upgrade` and resolve errors until upgrade is complete

## Links

<https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution>

<https://nixos.wiki/wiki/Home_Manager>

<https://discourse.nixos.org/t/github-strategies-for-configuration-nix/1983>

<https://github.com/michaelpj/nixos-config/blob/master/modules/home.nix>

<https://github.com/NixOS/nixpkgs/issues/154696#issuecomment-1012026159>

<https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager>

Mixing Channels

<https://discourse.nixos.org/t/allow-unfree-from-unstable/23218>

## Flakes and Direnv

<https://nixos.wiki/wiki/Flakes#Enable_flakes>

<https://github.com/nix-community/nix-direnv>

<https://determinate.systems/posts/nix-direnv>

## First Run (Host and VirtualBox)

```bash
nix-shell -p git just
git clone https://github.com/iancleary/nixos-config.git
cd nixos-config
# Set hostname
sudo nano /etc/nixos/configuration.nix
# after hostname is set, copy config over
sudo nixos-rebuild switch
just update upgrade

```

## SSH Authorized Keys (VirtualBox)

Setup a shared folder, copy the public ssh key over to `/mnt/shared/authorized_keys`.

Then run

```bash
cd /etc/nixos
sudo mkdir ssh
sudo cp /mnt/shared/authorized_keys /etc/nixos/ssh/authorized_keys
```

Add the authorized keyfile for your user

```nix
  users.users.{username}.openssh.authorizedKeys.keyFiles = [
    /etc/nixos/ssh/authorized_keys
  ];
```

Add `users/iancleary/authorized-keys.nix` to the `configuration.nix` file

## VirtualBox Resolution

On the host, add more than 32MB of video memory to get over 1920x1080 resolution.
