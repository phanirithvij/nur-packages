{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:ghostty-org/ghostty/05b580911577ae86e7a29146fac29fb368eab536";
in
f.packages.${system}.default
