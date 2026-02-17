{
  lib,
  stdenv,
  fetchFromGitHub,
  go,
  writableTmpDirAsHomeHook,
}:

stdenv.mkDerivation {
  pname = "difftrace";
  version = "0-unstable-2015-01-05";

  src = fetchFromGitHub {
    owner = "mattrco";
    repo = "difftrace";
    rev = "3de8b62791b297d82f82a7333b0830507525e242";
    hash = "sha256-qaN6UsPF8Y7cTIQ7VRCj9+g8VWUFKnrnRDJcgGkrCmE=";
  };

  nativeBuildInputs = [
    go
    writableTmpDirAsHomeHook
  ];

  buildPhase = ''
    mkdir -p $out/bin
    go mod init github.com/mattrco/difftrace
    go build -ldflags="-s"
    mv difftrace $out/bin
  '';

  meta = {
    description = "Parse and manipulate strace output for easier diffs";
    homepage = "https://github.com/mattrco/difftrace";
    license = lib.licenses.mit;
    mainProgram = "difftrace";
    maintainers = with lib.maintainers; [ phanirithvij ];
    platforms = lib.platforms.all;
    # TODO mark insecure
    # Last commit was 2015
  };
}
