{
  lib,
  fetchFromGitHub,
  tcount,
}:
tcount.overrideAttrs (
  finalAttrs: oldAttrs: {
    version = "0-unstable-2023-04-20";
    src = fetchFromGitHub {
      owner = "rrethy";
      repo = "tcount";
      rev = "341d9aa29512257bf7dfd7e843d02fdcfd583387";
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
