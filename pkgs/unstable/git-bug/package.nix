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
    version = "0.11.0-unstable-2026-09-26";
    src = fetchFromGitHub {
      owner = "git-bug";
      repo = "git-bug";
      rev = "8cebc504825ea3168099b002bf1a832c48f0458a";
      hash = "sha256-B8WSMCiyO2aqFfbmJOGJWFQB6zEyzX9wbaxBLTtNMk0=";
    };
    vendorHash = "sha256-TwAgpdlitF3O68wA+jyagifrLSRG7WCCZvJ1XJjP/pI=";
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
      hash = "sha256-K7AH/1ZY8qoN1nMVa0gsY7KDEzjHv4dliMhrLhxtnP8=";
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
