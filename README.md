# nixos-config

Welcome to my nixos-config!

## Setup Channels and Home Manager

### Channels

```bash
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos-unstable
sudo nix-channel --add https://channels.nixos.org/nixos-23.05 nixos
sudo nix-channel --update
```

Once that is done, you can:
```bash
sudo nix-channel --update nixos
sudo nix-channel --update nixos-unstable
```

### Home Manager

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
```

It is then possible to add

```nix
imports = [ <home-manager/nixos> ];
```

to your system configuration.nix file, which will introduce a new NixOS option called home-manager.users whose type is an attribute set that maps user names to Home Manager configurations.

### Flatpak

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

## Upgrading Versions

<https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module>
<https://nixos.org/manual/nixos/stable/index.html#sec-upgrading>

```bash
just version-update 23.11
```

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
just update
just switch
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
