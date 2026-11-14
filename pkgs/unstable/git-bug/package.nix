{
  git-bug,
  fetchFromGitHub,
  pnpm_10,
  fetchPnpmDeps,
}:
git-bug.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "git-bug";
    version = "0.12.0-unstable-2026-11-14";
    src = fetchFromGitHub {
      owner = "git-bug";
      repo = "git-bug";
      rev = "0abc9497f954a1ed4d5a5ebc8b88f262fc4983cf";
      hash = "sha256-HyzpvFW24K9gA5Ayd7/i/b8CPwauauOMhc1L9VxdPSg=";
    };
    vendorHash = "sha256-5wvgJOph8vTohvfxskpoPK98LuQi9CzN7jDgDATC6Mg=";
    ldflags = (prevAttrs.ldflags or [ ]) ++ [ "-s" ];

    webui = git-bug.webui.overrideAttrs (
      _: _: {
        inherit (finalAttrs) src version;
        pnpmDeps = fetchPnpmDeps {
          sourceRoot = "source/webui";
          inherit (finalAttrs)
            pname
            version
            src
            ;
          pnpm = pnpm_10;
          fetcherVersion = 5;
          hash = "sha256-bGi3N7niqG2OvfN/KhAg5H9XxiLhXbYmC/CBWK3pkP4=";
        };
      }
    );
  }
)
