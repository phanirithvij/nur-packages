{
  lib,
  fetchFromGitHub,
  fetchpatch,
  makeBinaryWrapper,
  nodejs,
  pnpm,
  replaceVars,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "rsshub";
  version = "0-unstable-2024-11-22";

  src = fetchFromGitHub {
    owner = "DIYgod";
    repo = "RSSHub";
    rev = "407658b9de7c6be1b4566edcba8041b7e93e968f";
    hash = "sha256-VQQMA1nT6LiIDJQjxZke2QO/W/KVNhU7g+UtFNzz0/c=";
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
    hash = "sha256-poMlmBks5GqsYhW8Mr7rQTCHA5AlfpInu+5S73lhbzU=";
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
