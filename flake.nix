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
      specialArgs = { inherit inputs; };

      desktop-system = "x86_64-linux";
      desktop-pkgs = (import nixpkgs) {
        system = desktop-system;
        config = {
          allowUnfree = true;
        };
      };

      vm-system = "x86_64-linux";
      vm-pkgs = (import nixpkgs) {
        system = vm-system;
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

    in {
      nixosConfigurations = {
        framework = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = desktop-system;
          pkgs = desktop-pkgs;
          modules = bare-metal-modules ++ common-modules ++ desktop-modules
            ++ [ 
                ./hardware-configuration.nix # hardware-configuration/framework.nix
                ./configuration.nix # hosts/framework.nix
                ./users/iancleary/bare-metal.nix
                ./users/iancleary/home-manager.nix
              ];
        };
        vm-icleary-nixos = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = vm-system;
          pkgs = vm-pkgs;
          modules = common-modules ++ virtualbox-guest-modules ++ desktop-modules
            ++ [ 
                ./hardware-configuration.nix # hardware-configuration/vm-icleary-nixos.nix
                ./configuration.nix # hosts/vm-icleary-nixos.nix
                ./users/icleary/vboxsf.nix
                ./users/icleary/home-manager.nix
              ];
        };
      };
    };
}
