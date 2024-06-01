# My NixOS configuration

[![Made with Neovim](https://img.shields.io/badge/Made%20with-Neovim-green&?style=flat&logo=neovim)](https://neovim.io)
[![NixOS](https://img.shields.io/badge/NixOS-24.05-blue?style=flat&logo=nixos&logoColor=white)](https://nixos.org)

## NixOS

### Installation (assuming host config already exists)

```bash
# All as root
HOST=...  # set host variable to use proper configuration

nix-shell
git clone https://this.repo.url/ /etc/nixos
cd /etc/nixos
sudo nixos-install --root /mnt --impure --flake .#$HOST

# Reboot
```

### System update

```bash
# Go to the repo directory
just switch
```

## Live ISO

```bash
nix build .#nixosConfigurations.isoimage.config.system.build.isoImage
```

## Resources

- [Nix config template](https://github.com/Misterio77/nix-starter-configs)
- [hlissner dotfiles](https://github.com/hlissner/dotfiles)
- [adfaure nix configuration](https://github.com/adfaure/nix_configuration)
- [Home-manager docs](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes)
- [Building NixOS ISO](https://ash64.eu/2022/03/08/custom-nixos-isos/)
- [NixOS manual](https://nixos.org/manual/nix/stable)
- [NixOS Configuration - Folder Structure This Repo was based on](https://github.com/LongerHV/nixos-configuration/tree/3d9baf05bc1bc34e2b9137a475db123e84b7aec5)
