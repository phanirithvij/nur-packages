{
  lib,
  stdenv,
  makeWrapper,
  fetchFromGitHub,

  pnpm,
  nodejs,
  fetchPnpmDeps,
  pnpmConfigHook,
}:
stdenv.mkDerivation rec {
  pname = "jampack";
  version = "0-unstable-2026-03-18";

  src = fetchFromGitHub {
    owner = "divriots";
    repo = "jampack";
    rev = "6b5410035f96b3f2bd34ba6067f68c6d461fa5a6";
    hash = "sha256-4gahwjYQCTPl5uBpRXi7gnA6fW/OYu5danTszeDb2SQ=";
  };
  patches = [ ./0001-pnpm-update-lock.patch ];

  pnpmDeps = fetchPnpmDeps {
    inherit
      pname
      version
      src
      patches
      ;
    hash = "sha256-c/SeiLZv2am0+oSdwx+KE/nXe6PsMlalrs51Z3HV3mA=";
    fetcherVersion = 2;
  };

  nativeBuildInputs = [
    pnpm
    nodejs
    pnpmConfigHook
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
    maintainers = with lib.maintainers; [ phanirithvij ];
  };
}
