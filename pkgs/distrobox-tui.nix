{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "distrobox-tui";
  version = "dev";

  src = fetchFromGitHub {
    owner = "phanirithvij";
    repo = "distrobox-tui";
    rev = "refs/heads/${version}";
    hash = "sha256-W20sXe85OX3dc5Z/kibTOC1fB71l3elVh6XxydVs+Nc=";
  };

  vendorHash = "sha256-zKJrhR/l2HPQXTVgrxYLGGz0pjA0e81jB6H4YrNfH94=";

  ldflags = [ "-s" ];

  meta = {
    description = "A TUI for DistroBox";
    changelog = "https://github.com/phanirithvij/distrobox-tui/releases/tag/v${version}";
    homepage = "https://github.com/phanirithvij/distrobox-tui";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "distrobox-tui";
  };
}
