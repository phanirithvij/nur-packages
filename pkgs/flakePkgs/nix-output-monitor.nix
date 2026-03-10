{
  fetchpatch2,
  stdenv,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/fb9c1d026adca43b84eabf101e0056c178ef113b";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
