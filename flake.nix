{
  description = "iancleary system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      x64_system = "x86_64-linux";

      x64_pkgs = {
        inherit nixpkgs;
        system = x64_system;
        config = {
          allowUnfree = true;
        };
      };

      bare-metal-modules = [
        ./modules/bare-metal/fwupd.nix
        ./modules/bare-metal/sound.nix
        ./modules/bare-metal/printing.nix
      ];

      virtualbox-guest-modules = [
        ./modules/virtualbox/guest-enabled.nix
      ];

      common-modules = [
        # variable setup
        ./modules/variables.nix

        # Flakes and Direnv
        ./modules/flakes.nix
        ./modules/nix-direnv.nix

        # Common
        ./modules/common/docker.nix
        ./modules/common/localBinInPath.nix
        ./modules/common/packages.nix
        ./modules/common/zsh.nix

        ./modules/networkmanager.nix
        ./modules/openssh.nix
        ./modules/garbage-collection.nix

        ./modules/unfree-allowed.nix

        # Locale and Timezone
        ./modules/localization/en_US.nix
        ./modules/timezone/America-Phoenix.nix
      ];

      personal-modules = [
        ./modules/tailscale.nix
      ];

      desktop-modules = [
        # Desktop Specific
        ./modules/desktop/flatpak.nix
        ./modules/desktop/gnome.nix
        ./modules/desktop/packages.nix
        ./modules/desktop/vscode.nix
        ./modules/desktop/x11-keymap.nix

      ];

    in
    {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          system = x64_system;
          pkgs = x64_pkgs;
          modules = bare-metal-modules ++ common-modules ++ desktop-modules
            ++ [
            ./hardware-configuration.nix # hardware-configuration/framework.nix
            ./configuration.nix # hosts/framework.nix
            ./home/default.nix
            ./users/iancleary.nix
          ];
        };
        vm-icleary-nixos = nixpkgs.lib.nixosSystem {
          system = x64_system;
          pkgs = x64_pkgs;
          modules = common-modules ++ virtualbox-guest-modules ++ desktop-modules
            ++ [
            ./hardware-configuration.nix # hardware-configuration/vm-icleary-nixos.nix
            ./configuration.nix # hosts/vm-icleary-nixos.nix
            ./home/default.nix
            ./users/icleary.nix
          ];
        };
      };
    };
}
