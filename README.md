# nixos-config

Welcome to my nixos-config!

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

## First Run (Host)

```bash
nix-shell -p git just
git clone https://github.com/iancleary/nixos-config.git
cd nixos-config
# Need to set hostname TODO
just update
just switch
```


## First Run (Virtual Box)

Edit:

* update hostname
* add user to `vboxsf` group (if in a virtualbox)
* add `just` and `git` to `environment.systemPackages`

Run:

```bash
cd /etc/nixos
sudo nixos-rebuild switch
sudo reboot now
```

Then setup a shared folder, copy the public ssh key over to `/mnt/shared/authorized_keys`.

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

> Then clone this repo onto the shared folder and use the [justfie](justfile) script to change the contents of `/etc/nixos/` to mirror this git repo.

**Setup home manager before rebuilding!**

## Home Manager

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
```

It is then possible to add

`imports = [ <home-manager/nixos> ];`
to your system configuration.nix file, which will introduce a new NixOS option called home-manager.users whose type is an attribute set that maps user names to Home Manager configurations.

## Desktop

### Flatpak

To install Flatpak, set NixOS option `services.flatpak.enable` to true by putting the following into your `/etc/nixos/configuration.nix`: 

```nix
  services.flatpak.enable = true;
```

Flathub is the best place to get Flatpak apps. To enable it, run:

```bash
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```
## Operating Sustem Upgrades

### Upgrade to 23.05

<https://nix-community.github.io/home-manager/index.html#sec-install-nixos-module>

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
```

<https://nixos.org/manual/nixos/stable/index.html#sec-upgrading>

```bash
sudo  nix-channel --add https://channels.nixos.org/nixos-23.05 nixos
nixos-rebuild switch --upgrade
```
