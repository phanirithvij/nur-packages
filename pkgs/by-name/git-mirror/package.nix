{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  perl,
  openssl,
}:

# TODO switch to getFlake once https://github.com/bachp/git-mirror/pull/529

rustPlatform.buildRustPackage rec {
  pname = "git-mirror";
  version = "0.14.16";

  src = fetchFromGitHub {
    owner = "bachp";
    repo = "git-mirror";
    rev = "3a78edc5aaa98eeda60ed2842b340ef4a83e9c7d";
    sha256 = "1jinrjxrj7csm03kldv171qzzcx4lqbjs6ks2zvrp6qh7kn0rf32";
  };

  nativeBuildInputs = [
    pkg-config
    perl
  ];
  buildInputs = [ openssl ];

  cargoHash = "sha256-Ewy0wBV8hjCiug0Y2omG1XJz+GyNnIDcroFXMWZIsIE=";
}
