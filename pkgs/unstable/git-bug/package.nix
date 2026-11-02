{
  git-bug,
  fetchFromGitHub,
  pnpm_10,
  fetchPnpmDeps,
}:
git-bug.overrideAttrs (
  finalAttrs: prevAttrs: {
    pname = "git-bug";
    version = "0.11.0-unstable-2026-10-29";
    src = fetchFromGitHub {
      owner = "git-bug";
      repo = "git-bug";
      rev = "a138b1542a03a1ea06b449e4acff374b95f53209";
      hash = "sha256-2P2PpNwI1Rh+DeoWtH6cSbTzZRcUv7EC8iUaDAb6x6k=";
    };
    vendorHash = "sha256-WFv6aXOlzFSuK6kQs9bZVvNZ1L1VF33143LZmoDg1xM=";
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
          fetcherVersion = 4;
          hash = "sha256-yVFXCOKqlDRdgoUOr+MqWEhGfRWxhasp3zJ9oWOR4bw=";
        };
      }
    );
  }
)
