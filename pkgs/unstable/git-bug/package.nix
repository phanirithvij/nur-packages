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
    version = "0.11.0-unstable-2026-10-12";
    src = fetchFromGitHub {
      owner = "git-bug";
      repo = "git-bug";
      rev = "cf2678d691295205e1e18a5c35bc6112ef54070b";
      hash = "sha256-wwgJK2KYCUQr+8WXdD6KlkuM8mL7WxoOSA5A0FZouS8=";
    };
    vendorHash = "sha256-/zjrvT7BBCQYZLAxLmARfsvTjwsxHi7SpqXgbSavrNw=";
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
