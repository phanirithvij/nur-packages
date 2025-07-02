{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:uncenter/nixpkgs-track/02c9aa6ecc63b30efb0bd388ac9d0c7b38f4f5e9";
in
f.packages.${system}.default.overrideAttrs (_: {
  pname = "nixpkgs-track";
  meta.mainProgram = "nixpkgs-track";
})
