_: p: {
  navi = p.navi.overrideAttrs (old: rec {
    pname = "navi";
    version = "master";
    src = p.fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "refs/heads/${version}";
      hash = "sha256-DBIEX1I+2hGY0CJ6RRXKP9d5EVURPcl10uNFuTgnI5w=";
    };
    cargoDeps = old.cargoDeps.overrideAttrs (
      p.lib.const {
        name = "${pname}-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-vNfcSHNP0KNM884DMtraYohLOvumSZnEtemJ+bJSQ5o=";
      }
    );
  });
}
