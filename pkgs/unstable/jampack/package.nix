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
  version = "0-unstable-2025-09-10";

  src = fetchFromGitHub {
    owner = "divriots";
    repo = "jampack";
    rev = "733bbed01c2c95821e77cb2d31f74ea26e9ac0cb";
    hash = "sha256-AtFO6k/VVzixhlV2yWF9zkHIXXl7U2F9H31r5Vk3pJ8=";
  };

  pnpmDeps = pnpm.fetchDeps {
    inherit pname version src;
    hash = "sha256-8RDRuutPGldFf9CYmVByG28dVyOoASmtDvlBs13DJPw=";
    fetcherVersion = 2;
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
