{
  system ? "x86_64-linux",
  fetchpatch2,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/07169b3894ab7cb1ee01d766145ab03bf2dc7a69";
in
f.packages.${system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
