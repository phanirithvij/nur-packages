{
  fetchpatch2,
  stdenv,
}:
let
  f = builtins.getFlake "github:maralorn/nix-output-monitor/4cbe3d92fad7934bf2e0738ec84267a49e075ec5";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  patches = [
    (fetchpatch2 {
      url = "https://github.com/maralorn/nix-output-monitor/pull/205.patch?full_index=1";
      hash = "sha256-fZvOUQRIDpIonMikvn6UwuG/HfXa3TO1tAX6EtXsB8E=";
    })
  ];
})
