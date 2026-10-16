{
  git-bug,
  fetchFromGitHub,
  pnpm_11,
  pnpmConfigHook,
  fetchPnpmDeps,
  nodejs,
}:
git-bug.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "git-bug";
    version = "0.11.0-unstable-2026-10-15";
    src = fetchFromGitHub {
      owner = "git-bug";
      repo = "git-bug";
      rev = "b7241c4adfeb4ce5de558e2bfb32a03593d35bda";
      hash = "sha256-8LRkTBexx1WEAWSX9j603iwsQuu7JVKQxaEFOOCpgtw=";
    };
    vendorHash = "sha256-FzuhtG4BcX2UWX1vSVrBpt4KTsiXYZuIA9fVf8Y4xtc=";
    ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];
    pnpmRoot = "webui";

    pnpmDeps = fetchPnpmDeps {
      sourceRoot = "source/webui";
      inherit (finalAttrs)
        pname
        version
        src
        ;
      pnpm = pnpm_11;
      fetcherVersion = 4;
      hash = "sha256-uEAGhMnkU+h/mBlDZ43IGDQpxkX0ssHHVeGChfVYDLo=";
    };

    nativeBuildInputs = (prevAttrs.nativeBuildInputs or [ ]) ++ [
      pnpm_11
      pnpmConfigHook
      nodejs
    ];

    # Don't run pnpm in this phase - filter out pnpmConfigHook
    # Also don't run preBuild of parent drv
    passthru.overrideModAttrs = oldAttrs: {
      nativeBuildInputs = builtins.filter (drv: drv != pnpmConfigHook) (
        oldAttrs.nativeBuildInputs or [ ]
      );
      preBuild = git-bug.goModules.preBuild or "";
    };

    preBuild = ''
      pushd webui
      pnpm build
      rm -rf node_modules
      popd
    '';
  }
)
