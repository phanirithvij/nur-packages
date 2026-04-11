{
  stdenv,
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/4004942844d4f9dad3c98723cd048dcb09a6f3a2";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  pname = "nixpkgs-track";
  meta.mainProgram = "nixpkgs-track";
})
