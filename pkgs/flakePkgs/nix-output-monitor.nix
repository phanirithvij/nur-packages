{
  fetchpatch2,
  stdenv,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/c40cb120262d9e9b1b988898708b124f6ffc0913";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  patches = [
    # https://github.com/maralorn/nix-output-monitor/pull/313
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/commit/0825c28af5a8576de1ea48e77336809756eadb84.patch?full_index=1";
      hash = "sha256-ywAeVNjATVg3Rk0jAs6LKwpWBAH4Kb725GJ1imBSLK0=";
      stripLen = 1;
    })
  ];
})
