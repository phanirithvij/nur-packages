{
  lib,
  fetchFromGitHub,
  fetchpatch,
  makeBinaryWrapper,
  nodejs,
  pnpm_9,
  replaceVars,
  stdenv,
}:
let
  pnpm = pnpm_9;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "rsshub";
  version = "0-unstable-2025-03-23";

  src = fetchFromGitHub {
    owner = "DIYgod";
    repo = "RSSHub";
    rev = "e48f05ec0b1705a8bda531ede1e1416fc3f710d7";
    hash = "sha256-JAVEKt1Euga6DhfFrmVrcfmSxqqD8bKPCfNoaIHxmTY=";
  };

  patches = [
    (replaceVars ./0001-fix-git-hash.patch {
      "GIT_HASH" = finalAttrs.src.rev;
    })
    (fetchpatch {
      url = "https://github.com/DIYgod/RSSHub/pull/17620.diff";
      hash = "sha256-vaVHw64jyc34BrqWWa0+TGHdPLpQbKZGkzSjr+t8zz8=";
    })
  ];

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-OrLWyyK5I9I04N0XjVNu7sehGSShxrx5p/zGHlYgXNc=";
  };

  nativeBuildInputs = [
    makeBinaryWrapper
    nodejs
    pnpm.configHook
  ];

  buildPhase = ''
    runHook preBuild

    pnpm build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib/rsshub
    cp -r lib node_modules assets api package.json tsconfig.json $out/lib/rsshub

    runHook postInstall
  '';

  preFixup = ''
    makeWrapper ${lib.getExe nodejs} $out/bin/rsshub \
      --chdir "$out/lib/rsshub" \
      --set "NODE_ENV" "production" \
      --set "NO_LOGFILES" "true" \
      --set "TSX_TSCONFIG_PATH" "$out/lib/rsshub/tsconfig.json" \
      --append-flags "$out/lib/rsshub/node_modules/tsx/dist/cli.mjs" \
      --append-flags "$out/lib/rsshub/lib/index.ts"
  '';

  meta = {
    description = "RSS feed generator";
    longDescription = ''
      RSSHub is an open source, easy to use, and extensible RSS feed generator.
      It's capable of generating RSS feeds from pretty much everything.

      RSSHub delivers millions of contents aggregated from all kinds of sources,
      our vibrant open source community is ensuring the deliver of RSSHub's new routes,
      new features and bug fixes.
    '';
    homepage = "https://docs.rsshub.app";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ Guanran928 ];
    mainProgram = "rsshub";
    platforms = lib.platforms.all;
  };
})
