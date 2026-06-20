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
    version = "0.10.1-unstable-2026-06-16";
    src = fetchFromGitHub {
      owner = "git-bug";
      repo = "git-bug";
      rev = "1a5e57dbf00c699ab5d176a9e5aace9baea64163";
      hash = "sha256-r8mVt/4IOKlZ4FjQ50rmrPrjaFhbJe28HVlTJ+waPsk=";
    };
    vendorHash = "sha256-cvzwDKo8vT0afmgJrlRiS6pwmobbOyoHgoIHTiuU898=";
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
      hash = "sha256-HyyOpr10IRLI5FYzqgmlY3mv/aGcLI0OEJCgKUGUsHk=";
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
