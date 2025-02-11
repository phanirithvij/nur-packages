_: p: {
  navi = p.navi.overrideAttrs (old: rec {
    pname = "navi";
    version = "master";
    src = p.fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "refs/heads/${version}";
      hash = "sha256-zvqxVu147u/m/4B3fhbuQ46txGMrlgQv9d4GGiR8SoQ=";
    };
    cargoDeps = old.cargoDeps.overrideAttrs (
      p.lib.const {
        name = "${pname}-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-3xUGeoMR/yjZBqKKxCnViISM8mFhLgcfRtDEV7yYXMw=";
      }
    );
  });
}
