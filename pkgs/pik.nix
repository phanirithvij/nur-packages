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
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "jacek-kurlit";
    repo = "pik";
    rev = version;
    hash = "sha256-q1nNQC9qGa7nUNIaDdqW3wIrfzH7JKS/yZAe9KNmX3k=";
  };

  cargoHash = "sha256-gqzt3cFOS4uzIstIvmPS0n18aFUt0YnoTRz7EVTV7sA=";

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
