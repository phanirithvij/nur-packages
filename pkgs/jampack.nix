{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  nodejs,
  pnpm,
}:

stdenv.mkDerivation rec {
  pname = "jampack";
  version = "0-unstable-2024-12-11";

  src = fetchFromGitHub {
    owner = "divriots";
    repo = "jampack";
    rev = "5c138398fa7e0f3b03b48d55613861a1d16bb0a7";
    hash = "sha256-my0Xw2B+auuRidWwtxV3jYOuWUnp9OeWDRBmy2eGawI=";
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
