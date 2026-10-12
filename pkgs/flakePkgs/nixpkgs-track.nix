{
  stdenv,
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/c337007f63e02a69a669e97896a0517145b02a2a";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  pname = "nixpkgs-track";
  meta.mainProgram = "nixpkgs-track";
})
