{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:e-tho/bzmenu/98c22a9f7f99ac5701ddf4b67d3d0808f7addca9";
in
f.packages.${system}.default
