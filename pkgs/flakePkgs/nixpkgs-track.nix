{
  stdenv,
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/ec171f87bd6e557cb9cc5a69306bc102e4997f4a";
in
f.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (_: {
  pname = "nixpkgs-track";
  meta.mainProgram = "nixpkgs-track";
})
