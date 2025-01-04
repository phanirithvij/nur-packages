{
  lib,
  fetchFromGitHub,
  tcount,
}:
tcount.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "master";
    src = fetchFromGitHub {
      owner = "rrethy";
      repo = "tcount";
      rev = "refs/heads/${finalAttrs.version}";
      hash = "sha256-M4EvaX9qDBYeapeegp6Ki7FJLFosVR1B42QRAh5Eugo=";
    };
    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (
      lib.const {
        inherit (finalAttrs) src;
        outputHash = "sha256-aUBGG/BD2ys2O50MuFlOOH4J+s0SfnuVAkYS9E4bQzA=";
        outputHashMode = "recursive";
      }
    );
  }
)
