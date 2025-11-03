{
  lib,
  stdenv,
  fetchFromGitHub,

  tinycc,
  ncurses,
}:

stdenv.mkDerivation {
  pname = "pendulum";
  version = "1.0.0-unstable-2025-02-10";

  src = fetchFromGitHub {
    owner = "Accacio";
    repo = "pendulum";
    rev = "fe28024780b9cbd14348bba0bf73cf264fda13ad";
    hash = "sha256-5RBxO9zvaM0qcywedEotkI0qqlrpgaPMzYPF4vlp9M4=";
  };

  patches = [
    ./0001-fix-Wimplicit-int-errors.patch
    ./0002-allow-control.c-from-args.patch
  ];

  buildInputs = [
    tinycc
    ncurses
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/share/doc/pendulum
    mv pendulum $out/bin
    mv control.c $out/share/doc/pendulum/control.c
    runHook postInstall
  '';

  meta = {
    description = "Inverted pendulum simulation on the terminal using c";
    homepage = "https://github.com/Accacio/pendulum";
    license = lib.licenses.unfree; # FIXME: https://github.com/Accacio/pendulum/issues/1
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "pendulum";
    platforms = lib.platforms.all;
  };
}
