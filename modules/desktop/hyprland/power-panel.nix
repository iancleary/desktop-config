{ pkgs
, lib
,
}:
rustPlatform.buildRustPackage rec {
  pname = "power-panel";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "iancleary";
    repo = pname;
    rev = version;
    sha256 = lib.fakeSha256;
  };

  cargoSha256 = lib.fakeSha256;

  # https://nixos.wiki/wiki/Packaging/Quirks_and_Caveats
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  buildInputs = with pkgs; [
    wayland
    gtk4
  ];

  preFixup = ''
    cat > $out/bin/power-panel <<EOF
    EOF
    chmod +x $out/bin/power-panel
  '';

  meta = with lib; {
    description = "Rust GUI app to restart and shutdown a system";
    homepage = "https://github.com/iancleary/power-panel";
    license = licenses.mit;
    maintainers = with maintainers; [ iancleary ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
