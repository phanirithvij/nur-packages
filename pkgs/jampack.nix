{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  nodejs,
  pnpm_9,
}:
let
  pnpm = pnpm_9;
in
stdenv.mkDerivation rec {
  pname = "jampack";
  version = "0-unstable-2025-01-07";

  src = fetchFromGitHub {
    owner = "divriots";
    repo = "jampack";
    rev = "3afe1d749d513c8e244cb800814d52dd71cde71d";
    hash = "sha256-SxLSPrixd3x5/5l5kIni4EKD8HA87G1U8HTi9zk/z9g=";
  };

  pnpmDeps = pnpm.fetchDeps {
    inherit pname version src;
    hash = "sha256-19/2KJDqnRYu9PI62tu2fVwtOdY1nklFcVj/4qa5wu4=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
    makeWrapper
  ];

  buildPhase = ''
    runHook preBuild
    pnpm build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/lib/jampack

    chmod +x dist/index.{js,d.ts}
    patchShebangs --build dist/index.{js,d.ts}
    mv dist/index.{js,mjs}

    substituteInPlace dist/packagejson.js \
      --replace-fail "../package.json" "./package.json"
    cp -r node_modules package.json $out/lib/jampack
    mv dist/* $out/lib/jampack

    makeWrapper ${nodejs}/bin/node $out/bin/jampack --add-flags $out/lib/jampack/index.mjs
    runHook postInstall
  '';

  meta = {
    description = "Optimizes static websites for best user experience and best Core Web Vitals scores";
    homepage = "https://github.com/divriots/jampack";
    license = lib.licenses.mit;
    mainProgram = "jampack";
  };
}
