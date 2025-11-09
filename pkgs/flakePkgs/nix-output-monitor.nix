{
  system ? "x86_64-linux",
  fetchpatch2,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/698e6f3afdc9d68dd65d84df7b030499dbfaf84b";
in
f.packages.${system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
