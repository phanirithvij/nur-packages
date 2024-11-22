{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "gama-tui";
  version = "1.1.4-unstable-2024-09-05";

  src = fetchFromGitHub {
    owner = "termkit";
    repo = "gama";
    rev = "5063d35e48f3118fa793965fcbb931ef3b330f02";
    hash = "sha256-2uZFDBsDF/nFnTIBrSDLr//J1rporkgjjzUYkZoKZgo=";
  };

  vendorHash = "sha256-U8D3o7KC62mo0Z2877gllgDY21zo8Vty4zILrwpWTdY=";

  ldflags = [
    "-s"
    "-X main.Version=v${version}-nix"
  ];

  # requires network access
  doCheck = false;

  meta = {
    description = "Manage your GitHub Actions from Terminal with great UI";
    homepage = "https://github.com/termkit/gama";
    changelog = "https://github.com/termkit/gama/releases";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "gama";
  };
}
