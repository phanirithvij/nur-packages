{
  system ? "x86_64-linux",
  fetchpatch2,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/5ebe2d0922f5fac056083b9818cb5832731d5418";
in
f.packages.${system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
