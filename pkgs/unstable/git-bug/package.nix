{
  git-bug,
  fetchFromGitHub,
  pnpm_10,
  fetchPnpmDeps,
}:
git-bug.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "git-bug";
    version = "0.11.0-unstable-2026-11-05";
    src = fetchFromGitHub {
      owner = "git-bug";
      repo = "git-bug";
      rev = "4ea4534b3a2ef956aa385eb98bb5646df180a5f3";
      hash = "sha256-hSDCeoowjwMcacYj0hAsKedLpbrfvIzawfZx9MvXAZY=";
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
          hash = "sha256-DNy1PkBiHUN5y993uNv/dNTDAStPX0Fzavg2Lxb8QBQ=";
        };
      }
    );
  }
)
