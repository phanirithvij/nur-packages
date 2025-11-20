{
  system ? "x86_64-linux",
  fetchpatch2,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/0cb46615fb8187e4598feac4ccf8f27a06aae0b7";
in
f.packages.${system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
