{
  system ? "x86_64-linux",
  fetchpatch2,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/2ba576d6bf7d80adf12492233f3284b9f2114d91";
in
f.packages.${system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
