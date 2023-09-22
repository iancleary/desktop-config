{ lib, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "power-panel";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "iancleary";
    repo = pname;
    rev = version;
    hash = lib.fakeSha256;
  };

  cargoHash = lib.fakeHash;

  meta = with lib; {
    description = "Rust GUI app to restart and shutdown a system";
    homepage = "https://github.com/iancleary/power-panel";
    license = licenses.mit;
    maintainers = with maintainers; [ iancleary ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
