{
  description = "My config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-hello-world.url = "github:iancleary/flake-hello-world";
  };

  outputs = 
    { self
    , nixpkgs
    , ...
    }@inputs:
    let
      inherit (self) output;
      forAllSystems = nixpkgs.lib.genAttrs [ "aarch64-linux" "x86_64-linux"];
      
    in
    rec {
      overlays = {
        unstable = final: prev: {
          unstable = nixpkgs-unstable.legacyPackages.${prev.system};
          inherit (nixpkgs-unstable.legacyPackages.${prev.system}) neovim-unwrapped;
        }
      };

      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        }
      );
      
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.callPackage ./shell.nix { };
        lint = nixpkgs.legacyPackages.${system}.callPackage ./shells/lint.nix { };
      });

      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);      
      
      nixosConfigurations = 
        let
          defaultModules = (builtins.attrValues nixosModules) ++ [

          ];
          specialArgs = { inherit inputs outputs; };

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

          gnome-desktop-modules = [
            ./modules/desktop # folder
            ./modules/desktop/gnome # folder
          ];


        in
          {
            framework = nixpkgs.lib.nixosSystem {
              inherit specialArgs;
              system = "x86_64-linux";
              modules = common-modules ++ gnome-desktop-modules ++ personal-modules
                ++ [
                ./hardware-configuration.nix # hardware-configuration/framework.nix
                ./configuration.nix # hosts/framework.nix
                ./home/iancleary-gnome.nix
              ];
            };
          };

      homeConfigurations = {
        # Ubuntu WSL at home
        iancleary = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = (builtins.attrValues homeManagerModules) ++ [
            ./home-manager/work.nix
          ];
        };
      }
    };
}
