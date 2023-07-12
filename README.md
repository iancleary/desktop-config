# nixos-config

Welcome to my nixos-config!

<https://nixos.wiki/wiki/Overview_of_the_NixOS_Linux_distribution>

<https://nixos.wiki/wiki/Home_Manager>

<https://discourse.nixos.org/t/github-strategies-for-configuration-nix/1983>

<https://github.com/michaelpj/nixos-config/blob/master/modules/home.nix>

<https://github.com/NixOS/nixpkgs/issues/154696#issuecomment-1012026159>

<https://www.bekk.christmas/post/2021/16/dotfiles-with-nix-and-home-manager>

## First Run

Edit:

* update hostname
* add user to `vboxsf` group (if in a virtualbox)
* add `just` to `environment.systemPackages`

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

> Then clone this repo onto the shared folder and run the [update-config.sh](update-config.sh) script to change the contents of `/etc/nixos/` to mirror this git repo.

**Setup home manager before rebuilding!**

## Home Manager

```bash
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update
```

It is then possible to add

`imports = [ <home-manager/nixos> ];`
to your system configuration.nix file, which will introduce a new NixOS option called home-manager.users whose type is an attribute set that maps user names to Home Manager configurations.

## Upgrade to 23.05

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
