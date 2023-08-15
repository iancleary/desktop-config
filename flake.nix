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
      desktop-modules = [
         # Host Specific
        ./users/iancleary/bare-metal.nix
        ./modules/tailscale.nix
        ./modules/bare-metal/fwupd.nix
        ./modules/bare-metal/sound.nix
        ./modules/bare-metal/printing.nix
        
        # Flakes and Direnv
        ./modules/flakes.nix
        ./modules/nix-direnv.nix

        # Locale and Timezone
        ./modules/localization/en_US.nix
        ./modules/timezone/America-Phoenix.nix

        # Desktop Specific
        ./modules/desktop/flatpak.nix
        ./modules/desktop/gnome.nix
        ./modules/desktop/packages.nix
        ./modules/desktop/vscode.nix
        ./modules/desktop/x11-keymap.nix

        # User Specific
        # <home-manager/nixos>
        ./users/iancleary/home-manager.nix

        # Common
        ./modules/common/docker.nix
        ./modules/common/localBinInPath.nix
        ./modules/common/packages.nix
        ./modules/common/zsh.nix

        ./modules/networkmanager.nix
        ./modules/openssh.nix
        ./modules/garbage-collection.nix

        ./modules/unfree-allowed.nix
      ];

    # #   personal-modules = [
    # #     ./modules/git-config-personal.nix
    # #     ./modules/password-manager-ssh.nix
    # #     ./modules/beeper.nix
    # #   ];

    # #   work-modules = [
    # #     ./modules/gcloud.nix
    # #     ./modules/git-config-work.nix
    # #     ./modules/user-bender.nix
    # #     ./modules/vagrant.nix
    # #     ./modules/xdg-utils.nix
    # #   ];

    #   server-system = "aarch64-linux";
    #   server-pkgs = (import nixpkgs) { system = server-system; };
    #   server-modules = [
    #     ./modules/arion.nix
    #     ./modules/cgm.nix
    #     ./modules/docker.nix
    #     ./modules/reverse-proxy.nix
    #     ./modules/secret-management.nix
    #     ./modules/ssh-server.nix
    #     ./modules/time.nix
    #     ./modules/users.nix
    #   ];
    in {
      nixosConfigurations = {
        nixos-framework = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = desktop-system;
          pkgs = desktop-pkgs;
          modules = desktop-modules
            ++ [ ./hardware-configuration/framework.nix ./hosts/nixos-framework.nix];
        };
      };

      devShells.x86_64-linux.default = with desktop-pkgs;
        stdenv.mkDerivation {
          name = "dotfiles";
          buildInputs = [ nixfmt nil ];
        };
    };
}
