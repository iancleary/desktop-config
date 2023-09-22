with import <nixos-unstable> { }; # bring all of Nixpkgs into scope
# { lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "power-panel";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "iancleary";
    repo = pname;
    rev = version;
    hash = "sha256-PJgFqFwl42c1W5oKYcacDMCcER/uHj7ucjzt4opvpfQ=";
  };

  # https://nixos.wiki/wiki/Packaging/Quirks_and_Caveats
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    wayland
    gtk4
  ];

  cargoHash = "sha256-aReLKWj3eCpQ4ct4gF+DfU37llrqyVqKd9R2OJ/3p7g=";

  meta = with lib; {
    description = "Rust GUI app to restart and shutdown a system";
    homepage = "https://github.com/iancleary/power-panel";
    license = licenses.mit;
    maintainers = with maintainers; [ iancleary ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
