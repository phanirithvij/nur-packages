{
  lib,
  fetchpatch,
  fetchFromGitHub,
  makeBinaryWrapper,

  pnpm,
  nodejs,
  fetchPnpmDeps,
  pnpmConfigHook,

  stdenv,
  replaceVars,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "rsshub";
  version = "0-unstable-2026-01-14";

  src = fetchFromGitHub {
    owner = "DIYgod";
    repo = "RSSHub";
    rev = "671f05e645c3c5d864e1445a8dab4a7c4c5480f1";
    hash = "sha256-W8cSF92Dl4I0TEfPCH8QXudi6BfTspkcPJw/rwQkNE8=";
  };

  patches = [
    (replaceVars ./0001-fix-git-hash.patch {
      "GIT_HASH" = finalAttrs.src.rev;
    })
    ./0002-fix-network-call.patch
    (fetchpatch {
      url = "https://github.com/DIYgod/RSSHub/pull/17620.diff";
      hash = "sha256-vaVHw64jyc34BrqWWa0+TGHdPLpQbKZGkzSjr+t8zz8=";
    })
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit pnpm;
    fetcherVersion = 3;
    hash = "sha256-+NTA0lzTXKbESZM7RJeHU1aU/xRGQ//7lqnbpSvYGWA=";
  };

  nativeBuildInputs = [
    pnpm
    nodejs
    pnpmConfigHook
    makeBinaryWrapper
  ];

  buildPhase = ''
    runHook preBuild
    pnpm build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/lib/rsshub
    cp -r lib node_modules assets package.json tsconfig.json $out/lib/rsshub
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
