{
  stdenv,
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/57a60cfd4838217e30f90a7e1c356e90ecd12ff9";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  pname = "nixpkgs-track";
  meta.mainProgram = "nixpkgs-track";
})
