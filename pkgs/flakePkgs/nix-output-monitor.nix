{
  fetchpatch2,
  stdenv,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/ea3731cbb921dc728ed611614f542fd6b76d4524";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
