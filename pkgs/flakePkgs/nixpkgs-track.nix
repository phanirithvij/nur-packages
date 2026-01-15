{
  stdenv,
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/bb00d9aa5e574bd747ee352c9b3df3ad92ea1a2a";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  pname = "nixpkgs-track";
  meta.mainProgram = "nixpkgs-track";
})
