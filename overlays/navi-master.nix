_: p: {
  navi = p.navi.overrideAttrs (old: rec {
    pname = "navi";
    version = "master";
    src = p.fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "refs/heads/${version}";
      hash = "sha256-TaB5opb7al+33qIrK/EPhkNChyr96I+9R1euU4bDj38=";
    };
    cargoDeps = old.cargoDeps.overrideAttrs (
      p.lib.const {
        name = "${pname}-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-G1HGpx4Df0aAtb4sx3HLI4iyvF5DBEylt2tFMjN1XSc=";
      }
    );
  });
}
