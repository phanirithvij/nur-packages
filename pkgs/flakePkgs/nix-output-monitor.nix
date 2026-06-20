{
  fetchpatch2,
  stdenv,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/71963f8de25875a4c03f2a0b61c658fa4eb2ce07";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
