{
  git-bug,
  fetchFromGitHub,
  pnpm_10,
  fetchPnpmDeps,
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
          hash = "sha256-j5HhRnz1tl7aOg/KQFnH8B5Ie87OcQwn5BfTG9/JIm4=";
        };
      }
    );
  }
)
