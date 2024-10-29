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
  version = "0-unstable-2024-10-11";

  src = fetchFromGitHub {
    owner = "divriots";
    repo = "jampack";
    rev = "08438debb7c253a7dc238a669d13161328608e1d";
    hash = "sha256-CtgQA+sQdN3P6uZyJ0NLW+D5vmLmY68kF4A9xLjCVZo=";
  };

  pnpmDeps = pnpm.fetchDeps {
    inherit pname version src;
    hash = "sha256-Z7bq2C+VdG1gbPTCjhIGNot4KIXiar1eeYVsXZteFk8=";
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
