{
  fetchpatch2,
  stdenv,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/3ab77f90dd817ad95a45e07764cb71ac762f0668";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
