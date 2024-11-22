# nix-init, immaculate
{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "pik";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "jacek-kurlit";
    repo = "pik";
    rev = version;
    hash = "sha256-EeBu8AArbBnoUIrs8Sb1BnjR3fjE7XzXBnPITRsqMFc=";
  };

  cargoHash = "sha256-rZKn0HxFKOKaKMLdWEqsAva+H0gFcCBuJNjZh/uWNMM=";

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.IOKit
  ];

  meta = {
    description = "Process Interactive Kill";
    homepage = "https://github.com/jacek-kurlit/pik";
    license = lib.licenses.mit;
    mainProgram = "pik";
  };
}
