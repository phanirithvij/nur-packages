{
  fetchFromGitHub,
  tcount,
}:
tcount.overrideAttrs (
  finalAttrs: _: {
    version = "master";
    src = fetchFromGitHub {
      owner = "rrethy";
      repo = "tcount";
      rev = "refs/heads/${finalAttrs.version}";
      hash = "sha256-M4EvaX9qDBYeapeegp6Ki7FJLFosVR1B42QRAh5Eugo=";
    };
    cargoHash = "sha256-Sn7hu+2jQFd2u8tpfTxnEO+syrO96gfgz6ouHxJnpLg=";
  }
)
