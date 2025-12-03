{
  stdenv,
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/44937e8126698f70549510e8ee311e6a5fcb4f8c";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  pname = "nixpkgs-track";
  meta.mainProgram = "nixpkgs-track";
})
